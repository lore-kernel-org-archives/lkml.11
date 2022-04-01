Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FF3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 15:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349425AbiDAPcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349955AbiDAO61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:58:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1A8170DB1;
        Fri,  1 Apr 2022 07:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20D60B8240E;
        Fri,  1 Apr 2022 14:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53E9C3410F;
        Fri,  1 Apr 2022 14:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648824333;
        bh=ie3ERVJUGrppjLIYAsm6LgtD05Un/FhSK3Ao2Boc3ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aSrx1JGNKm0Ia8LS9Dw9ozpSQlLIzWTfHP87LlM2QReH+yMfVYrEQHTGDPwdFCLtR
         qOZ1hcjxaUcgE8Uh5Iz+I6vcPXGY5C3oCnSCv9G1oCFtv2kRFmdRtYgKSYgCRzwGna
         o9qp6QmFm7RajwZgsu4f5a6iLLvKOcXaEKB/km/iYP7eZil1dZt67yVfNIHrktqPW3
         DcqiFttO43e/5a6jR5x7+xhtAXcnCf5IkZ7R9eeqqrchHK+jAAp02CZgAznyU8zAHL
         RlxUuv/udiQMAjQfJFIkorYiVOeuNc1FcCoS7eHnVKGilXr/054u64+hiZdqE/NeW9
         qVJVmmyBAc7BQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jordy Zomer <jordy@jordyzomer.github.io>,
        Jordy Zomer <jordy@pwning.systems>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>, agk@redhat.com,
        snitzer@kernel.org, dm-devel@redhat.com
Subject: [PATCH AUTOSEL 5.4 19/37] dm ioctl: prevent potential spectre v1 gadget
Date:   Fri,  1 Apr 2022 10:44:28 -0400
Message-Id: <20220401144446.1954694-19-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401144446.1954694-1-sashal@kernel.org>
References: <20220401144446.1954694-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordy Zomer <jordy@jordyzomer.github.io>

[ Upstream commit cd9c88da171a62c4b0f1c70e50c75845969fbc18 ]

It appears like cmd could be a Spectre v1 gadget as it's supplied by a
user and used as an array index. Prevent the contents of kernel memory
from being leaked to userspace via speculative execution by using
array_index_nospec.

Signed-off-by: Jordy Zomer <jordy@pwning.systems>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 3f15d8dc2b71..7a73f2fa0ad7 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -17,6 +17,7 @@
 #include <linux/dm-ioctl.h>
 #include <linux/hdreg.h>
 #include <linux/compat.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 
@@ -1696,6 +1697,7 @@ static ioctl_fn lookup_ioctl(unsigned int cmd, int *ioctl_flags)
 	if (unlikely(cmd >= ARRAY_SIZE(_ioctls)))
 		return NULL;
 
+	cmd = array_index_nospec(cmd, ARRAY_SIZE(_ioctls));
 	*ioctl_flags = _ioctls[cmd].flags;
 	return _ioctls[cmd].fn;
 }
-- 
2.34.1

