Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987A7C4707E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 15:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356931AbiDNPZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 11:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347033AbiDNN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:58:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F6AB6D0D;
        Thu, 14 Apr 2022 06:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7757B82894;
        Thu, 14 Apr 2022 13:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23212C385A5;
        Thu, 14 Apr 2022 13:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649944112;
        bh=ZK9bnx/lyZZ9oKvnCjW+4Ll2OOuQv7jyiZ83Vdpi3Bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FbveaBUe/ZLxe0sxPrTSBp6agJw0KfmnTbtwFeS2gZeTgrjRIpmf0gDVzdSPxfqRv
         ypia2xduVR++Da7QA5x5dOoWv45VEpB8GSHoTnGlbISthsnFqg0vzsVrMYsYu6gq3p
         6xli96TH/iYW6nB1XeNjZ1OkLVuHEzTSwlYvFHT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jordy Zomer <jordy@pwning.systems>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 391/475] dm ioctl: prevent potential spectre v1 gadget
Date:   Thu, 14 Apr 2022 15:12:56 +0200
Message-Id: <20220414110906.014386562@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110855.141582785@linuxfoundation.org>
References: <20220414110855.141582785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
2.35.1



