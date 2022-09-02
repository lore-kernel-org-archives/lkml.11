Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7222C38145
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 12:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbiIBMWn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 08:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbiIBMVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:21:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF10A9265;
        Fri,  2 Sep 2022 05:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2185620E6;
        Fri,  2 Sep 2022 12:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F5DC433C1;
        Fri,  2 Sep 2022 12:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662121273;
        bh=EjhUaWhI2U+NFj+HyzZDRmEuXJdOa2MKK3y3jt7QK4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wCCVqAdBKwmPnvAsvIiImcg/Vs5f9yWFr2/i1TcqNa9rFY8Q2Fxf188yFjZ6YvZgZ
         cpU7Dt38cfj0mI8J8IAhenEnr888pKw1+R0qs/nrl9vaqGGaEzWenTYJM0Lg2fUiKr
         mnCGGAu0pi81skmRqXPYS6npJUNkKTketOftNtsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 28/31] s390/hypfs: avoid error message under KVM
Date:   Fri,  2 Sep 2022 14:18:54 +0200
Message-Id: <20220902121357.770385533@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220902121356.732130937@linuxfoundation.org>
References: <20220902121356.732130937@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

[ Upstream commit 7b6670b03641ac308aaa6fa2e6f964ac993b5ea3 ]

When booting under KVM the following error messages are issued:

hypfs.7f5705: The hardware system does not support hypfs
hypfs.7a79f0: Initialization of hypfs failed with rc=-61

Demote the severity of first message from "error" to "info" and issue
the second message only in other error cases.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Link: https://lore.kernel.org/r/20220620094534.18967-1-jgross@suse.com
[arch/s390/hypfs/hypfs_diag.c changed description]
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/hypfs/hypfs_diag.c | 2 +-
 arch/s390/hypfs/inode.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 794bebb43d23d..64448c0998eb5 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -436,7 +436,7 @@ __init int hypfs_diag_init(void)
 	int rc;
 
 	if (diag204_probe()) {
-		pr_err("The hardware system does not support hypfs\n");
+		pr_info("The hardware system does not support hypfs\n");
 		return -ENODATA;
 	}
 	if (diag204_info_type == DIAG204_INFO_EXT) {
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 224aeda1e8ccf..d73d2d001a620 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -493,9 +493,9 @@ static int __init hypfs_init(void)
 	hypfs_vm_exit();
 fail_hypfs_diag_exit:
 	hypfs_diag_exit();
+	pr_err("Initialization of hypfs failed with rc=%i\n", rc);
 fail_dbfs_exit:
 	hypfs_dbfs_exit();
-	pr_err("Initialization of hypfs failed with rc=%i\n", rc);
 	return rc;
 }
 
-- 
2.35.1



