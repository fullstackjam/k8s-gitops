package main

import (
	"log"
	"os"

	"code.gitea.io/sdk/gitea"
	"gopkg.in/yaml.v2"
)

type Organization struct {
	Name        string
	Description string
}

type Repository struct {
	Name    string
	Owner   string
	Private bool
	Migrate struct {
		Source string
		Mirror bool
	}
}

type User struct {
	Name           string
	FullName       string `yaml:"fullName"`
	Email          string
	TokenSecretRef string `yaml:"tokenSecretRef"`
}

type Config struct {
	Users         []User         `yaml:"users"`
	Organizations []Organization `yaml:"organizations"`
	Repositories  []Repository   `yaml:"repositories"`
}

func main() {
	data, err := os.ReadFile("./config.yaml")
	if err != nil {
		log.Fatalf("Unable to read config file: %v", err)
	}

	config := Config{}
	err = yaml.Unmarshal([]byte(data), &config)
	if err != nil {
		log.Fatalf("error parsing YAML: %v", err)
	}

	// 读取 Gitea 连接信息
	giteaHost := os.Getenv("GITEA_HOST")
	giteaUser := os.Getenv("GITEA_USER")
	giteaPassword := os.Getenv("GITEA_PASSWORD")

	// 连接 Gitea
	client, err := gitea.NewClient(giteaHost, gitea.SetBasicAuth(giteaUser, giteaPassword))
	if err != nil {
		log.Fatal(err)
	}

	for _, user := range config.Users {
		existingUser, _, err := client.GetUserInfo(user.Name)
		if err == nil && existingUser != nil {
			log.Printf("User %s already exists, skipping creation.", user.Name)
			continue
		}

		_, _, err = client.AdminCreateUser(gitea.CreateUserOption{
			Username:           user.Name,
			FullName:           user.FullName,
			Email:              user.Email,
			MustChangePassword: gitea.OptionalBool(false),
			Password:           "change_me_later", // 这里可以随机生成密码，或者从 Secret 读取
			SendNotify:         false,
		})

		if err != nil {
			log.Printf("Failed to create user %s: %v", user.Name, err)
		} else {
			log.Printf("Created user %s successfully.", user.Name)
		}
	}

	// 创建组织
	for _, org := range config.Organizations {
		_, _, err = client.CreateOrg(gitea.CreateOrgOption{
			Name:        org.Name,
			Description: org.Description,
		})
		if err != nil {
			log.Printf("Create organization %s: %v", org.Name, err)
		}
	}

	// 创建仓库或迁移仓库
	for _, repo := range config.Repositories {
		if repo.Migrate.Source != "" {
			_, _, err = client.MigrateRepo(gitea.MigrateRepoOption{
				RepoName:       repo.Name,
				RepoOwner:      repo.Owner,
				CloneAddr:      repo.Migrate.Source,
				Service:        gitea.GitServicePlain,
				Mirror:         repo.Migrate.Mirror,
				Private:        repo.Private,
				MirrorInterval: "10m",
			})
			if err != nil {
				log.Printf("Migrate %s/%s: %v", repo.Owner, repo.Name, err)
			}
		} else {
			_, _, err = client.AdminCreateRepo(repo.Owner, gitea.CreateRepoOption{
				Name:    repo.Name,
				Private: repo.Private,
			})
			if err != nil {
				log.Printf("Create repo %s/%s: %v", repo.Owner, repo.Name, err)
			}
		}
	}
}
