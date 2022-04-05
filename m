Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9ACC43219
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 23:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiDEX1W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 19:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243730AbiDEKhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:37:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B091255766;
        Tue,  5 Apr 2022 03:23:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37BB1B81B18;
        Tue,  5 Apr 2022 10:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816A9C385A2;
        Tue,  5 Apr 2022 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649154178;
        bh=3arK47s3mm6uyX8/+rui0IYzUFmtvrOLWmgcwKONhzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hd4Y+QMQpO3Ak41RZyHkQA0NUV8gy08w4Vm6o4InNFpbU4FS60gwEtX/1ACK5dHU0
         hTO85YYRORDQj+3olrpDLc6auSPo96UbiahESfbLLnmGRB3AjsKj80D5xns4TkQVma
         ZIiBwHaYya1vVLk7E2xfIGqsAbWanzd/m8eZffeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 449/599] LSM: general protection fault in legacy_parse_param
Date:   Tue,  5 Apr 2022 09:32:23 +0200
Message-Id: <20220405070312.190485023@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>

[ Upstream commit ecff30575b5ad0eda149aadad247b7f75411fd47 ]

The usual LSM hook "bail on fail" scheme doesn't work for cases where
a security module may return an error code indicating that it does not
recognize an input.  In this particular case Smack sees a mount option
that it recognizes, and returns 0. A call to a BPF hook follows, which
returns -ENOPARAM, which confuses the caller because Smack has processed
its data.

The SELinux hook incorrectly returns 1 on success. There was a time
when this was correct, however the current expectation is that it
return 0 on success. This is repaired.

Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: James Morris <jamorris@linux.microsoft.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/security.c      | 17 +++++++++++++++--
 security/selinux/hooks.c |  5 ++---
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/security/security.c b/security/security.c
index a864ff824dd3..d9d42d64f89f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -860,9 +860,22 @@ int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
 	return call_int_hook(fs_context_dup, 0, fc, src_fc);
 }
 
-int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param)
+int security_fs_context_parse_param(struct fs_context *fc,
+				    struct fs_parameter *param)
 {
-	return call_int_hook(fs_context_parse_param, -ENOPARAM, fc, param);
+	struct security_hook_list *hp;
+	int trc;
+	int rc = -ENOPARAM;
+
+	hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
+			     list) {
+		trc = hp->hook.fs_context_parse_param(fc, param);
+		if (trc == 0)
+			rc = 0;
+		else if (trc != -ENOPARAM)
+			return trc;
+	}
+	return rc;
 }
 
 int security_sb_alloc(struct super_block *sb)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 86159b32921c..63e61f2f1ad6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2820,10 +2820,9 @@ static int selinux_fs_context_parse_param(struct fs_context *fc,
 		return opt;
 
 	rc = selinux_add_opt(opt, param->string, &fc->security);
-	if (!rc) {
+	if (!rc)
 		param->string = NULL;
-		rc = 1;
-	}
+
 	return rc;
 }
 
-- 
2.34.1



