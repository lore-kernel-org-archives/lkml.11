Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA74C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 00:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386330AbiFHA3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385312AbiFGWVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:21:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A458C19A726;
        Tue,  7 Jun 2022 12:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A01F60A1D;
        Tue,  7 Jun 2022 19:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7C3C385A5;
        Tue,  7 Jun 2022 19:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654629688;
        bh=5or48Sd0+2qQPDKl+woFHQA/id1AA8D8c0YmSyWFprU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UpoZWbTIvLuWoxcMu2sLHJp4ZbqnWhOYe30uiveNxPPf67VgDvj3KpJnpvn07yQmw
         jZ0Dy3h1xciyIajAFAp1JM1TEpfpmIuLRHgDGntbcx7OXybwSIRpKUI7qgBF490G0R
         6sbdQL4yla24hv8MS6zBK5RlYW15ddhNkWB2qvzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH 5.18 781/879] selftests/landlock: Extend access right tests to directories
Date:   Tue,  7 Jun 2022 19:04:59 +0200
Message-Id: <20220607165025.541305893@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607165002.659942637@linuxfoundation.org>
References: <20220607165002.659942637@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mickaël Salaün <mic@digikod.net>

commit d18955d094d09a220cf8f533f5e896a2fe31575a upstream.

Make sure that all filesystem access rights can be tied to directories.

Rename layout1.file_access_rights to layout1.file_and_dir_access_rights
to reflect this change.

Cc: Shuah Khan <shuah@kernel.org>
Link: https://lore.kernel.org/r/20220506160820.524344-6-mic@digikod.net
Cc: stable@vger.kernel.org
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/landlock/fs_test.c |   30 +++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -418,11 +418,12 @@ TEST_F_FORK(layout1, inval)
 
 /* clang-format on */
 
-TEST_F_FORK(layout1, file_access_rights)
+TEST_F_FORK(layout1, file_and_dir_access_rights)
 {
 	__u64 access;
 	int err;
-	struct landlock_path_beneath_attr path_beneath = {};
+	struct landlock_path_beneath_attr path_beneath_file = {},
+					  path_beneath_dir = {};
 	struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = ACCESS_ALL,
 	};
@@ -432,20 +433,33 @@ TEST_F_FORK(layout1, file_access_rights)
 	ASSERT_LE(0, ruleset_fd);
 
 	/* Tests access rights for files. */
-	path_beneath.parent_fd = open(file1_s1d2, O_PATH | O_CLOEXEC);
-	ASSERT_LE(0, path_beneath.parent_fd);
+	path_beneath_file.parent_fd = open(file1_s1d2, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath_file.parent_fd);
+
+	/* Tests access rights for directories. */
+	path_beneath_dir.parent_fd =
+		open(dir_s1d2, O_PATH | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath_dir.parent_fd);
+
 	for (access = 1; access <= ACCESS_LAST; access <<= 1) {
-		path_beneath.allowed_access = access;
+		path_beneath_dir.allowed_access = access;
+		ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
+					       LANDLOCK_RULE_PATH_BENEATH,
+					       &path_beneath_dir, 0));
+
+		path_beneath_file.allowed_access = access;
 		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-					&path_beneath, 0);
-		if ((access | ACCESS_FILE) == ACCESS_FILE) {
+					&path_beneath_file, 0);
+		if (access & ACCESS_FILE) {
 			ASSERT_EQ(0, err);
 		} else {
 			ASSERT_EQ(-1, err);
 			ASSERT_EQ(EINVAL, errno);
 		}
 	}
-	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	ASSERT_EQ(0, close(path_beneath_file.parent_fd));
+	ASSERT_EQ(0, close(path_beneath_dir.parent_fd));
+	ASSERT_EQ(0, close(ruleset_fd));
 }
 
 TEST_F_FORK(layout1, unknown_access_rights)


