Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F370AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 19:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiBXTVd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiBXTVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:21:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B99E20DB14
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:20:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r14-20020a5b018e000000b00624f6f97bf4so749180ybl.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vE/X1GbuMiKSRX0usgoudNG0PjnPYCjAGGaX0qNgdQ8=;
        b=FyIQHr8etZ6mQPzxRUPRdn7PmSB8K6WWQcG0zuVMBr9gpJ/alDA89zNcWsJ4HuE6CC
         SgTlSwM7IDbbLSAKUZP59OTJEtIB8IZFMGa5PVl+3S1BqdxMEvz1zd3WqUp6DmoXfLVw
         MDyNu2RMhZiAhfdoTZWxAG0mtU4YSLTE6urpO5x6G1xxSryZmnQKbD4Rpw6pvIxCEbt2
         yn5c6PvJOKsMbtUqTwnYRgRJ2HbSxZJlIm56fARhp+LJfl65uZME7oNNb/Ef5JzWKOGz
         vE5iyL3XqhvmivHQYhP2reoPfdSessoG5yU+JV8uarMTW9k9CcJPvGdWgx5CPISAh5si
         c1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vE/X1GbuMiKSRX0usgoudNG0PjnPYCjAGGaX0qNgdQ8=;
        b=kedednHJ0gU6PI6k17FDlcFoEiXnR/lx6eFw8hp8MsmUhjgKUe6I4hauWShbRxIfTv
         d8it0KRy5mMftOSs++zB8Vj3y+LKAGUxw0DT8WNfQtbnJl7SgOY8LhSqL/K0rotTxeEv
         FDknkIJj3Jj+48nIVr1gQvqHsPcOru0hrS29s4BmXqIZmXV0QvYodXTPRvZLzfpGgRge
         CmzKZFkt4kyDeXiUSegOafMMIEDZUeV6ZeLr0hi69tX/8openlyFs42XqMFdjVIej15O
         vjOI2HObaKAP03lJppGbytz7PoA+fkaf+HN8NWB6O33hcFmSR1THpqprDndS+IUpjpG0
         OZ1A==
X-Gm-Message-State: AOAM533YD7DUE899zRNNHTZ11uMvWxI/OhPmDyI2XJyVx3UJSx4WJtFG
        FC7u8C+uZ7yPNpGhHKyLUTOQ5DykbWxt/Q==
X-Google-Smtp-Source: ABdhPJx3bs6AIpTEF94dmhDZdm3O1wxL83posi8M5rPdjILtbKKCumct8m3TAQP07sYhvg4456vXi9CepZb2uA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:96e5:fbf5:15ed:8b6f])
 (user=dlatypov job=sendgmr) by 2002:a25:aa4a:0:b0:624:6220:e4f8 with SMTP id
 s68-20020a25aa4a000000b006246220e4f8mr3869090ybi.531.1645730452359; Thu, 24
 Feb 2022 11:20:52 -0800 (PST)
Date:   Thu, 24 Feb 2022 11:20:34 -0800
Message-Id: <20220224192036.2388302-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 1/3] kunit: tool: readability tweaks in KernelCI json
 generation logic
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a more idiomatic check that a list is non-empty (`if mylist:`) and
simplify the function body by dedenting and using a dict to map between
the kunit TestStatus enum => KernelCI json status string.

The dict hopefully makes it less likely to have bugs like commit
9a6bb30a8830 ("kunit: tool: fix --json output for skipped tests").

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_json.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index 24d103049bca..14a480d3308a 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -16,24 +16,24 @@ from typing import Any, Dict
 
 JsonObj = Dict[str, Any]
 
+_status_map: Dict[TestStatus, str] = {
+	TestStatus.SUCCESS: "PASS",
+	TestStatus.SKIPPED: "SKIP",
+	TestStatus.TEST_CRASHED: "ERROR",
+}
+
 def _get_group_json(test: Test, def_config: str, build_dir: str) -> JsonObj:
 	sub_groups = []  # List[JsonObj]
 	test_cases = []  # List[JsonObj]
 
 	for subtest in test.subtests:
-		if len(subtest.subtests):
+		if subtest.subtests:
 			sub_group = _get_group_json(subtest, def_config,
 				build_dir)
 			sub_groups.append(sub_group)
-		else:
-			test_case = {"name": subtest.name, "status": "FAIL"}
-			if subtest.status == TestStatus.SUCCESS:
-				test_case["status"] = "PASS"
-			elif subtest.status == TestStatus.SKIPPED:
-				test_case["status"] = "SKIP"
-			elif subtest.status == TestStatus.TEST_CRASHED:
-				test_case["status"] = "ERROR"
-			test_cases.append(test_case)
+			continue
+		status = _status_map.get(subtest.status, "FAIL")
+		test_cases.append({"name": subtest.name, "status": status})
 
 	test_group = {
 		"name": test.name,
-- 
2.35.1.574.g5d30c73bfb-goog

