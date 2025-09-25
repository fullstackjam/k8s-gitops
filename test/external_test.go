package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/external"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestTerraformExternal(t *testing.T) {
	t.Parallel()

	// Make a copy of the external module to a temporary directory. This allows running multiple tests in parallel
	// against the same external module.
	exampleFolder := test_structure.CopyTerraformFolderToTemp(t, "../external", ".")

	externalOptions := external.WithDefaultRetryableErrors(t, &external.Options{
		TerraformDir: exampleFolder,
	})

	external.Init(t, externalOptions)
	external.Validate(t, externalOptions)
}
