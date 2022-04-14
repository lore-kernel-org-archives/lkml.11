Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB64C4707F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345484AbiDNPAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 11:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346224AbiDNN4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6B1B0A5F;
        Thu, 14 Apr 2022 06:46:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B969761D9C;
        Thu, 14 Apr 2022 13:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFB6C385A1;
        Thu, 14 Apr 2022 13:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649943959;
        bh=r/23rai1XYWj99x1LqgrFVJjqYMbSUUW/TywEyI4vQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8LDMvyJY0AhNeftpCkBpyZtTULb0msFMGfA1CoVwcDGO5IVdB2s8X1TavNaEbf4D
         FMXVzrHfYY5gOxArH8lPioRPFQ1AKTfu1GaBVu12dREPqvBHCwWCGLpr1P4AKp85OP
         x53paXG7mR2Md1mHr3SGPCE0LAgiHBsaeAqxQG2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Price <anprice@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 5.4 342/475] gfs2: Make sure FITRIM minlen is rounded up to fs block size
Date:   Thu, 14 Apr 2022 15:12:07 +0200
Message-Id: <20220414110904.653596274@linuxfoundation.org>
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

From: Andrew Price <anprice@redhat.com>

commit 27ca8273fda398638ca994a207323a85b6d81190 upstream.

Per fstrim(8) we must round up the minlen argument to the fs block size.
The current calculation doesn't take into account devices that have a
discard granularity and requested minlen less than 1 fs block, so the
value can get shifted away to zero in the translation to fs blocks.

The zero minlen passed to gfs2_rgrp_send_discards() then allows
sb_issue_discard() to be called with nr_sects == 0 which returns -EINVAL
and results in gfs2_rgrp_send_discards() returning -EIO.

Make sure minlen is never < 1 fs block by taking the max of the
requested minlen and the fs block size before comparing to the device's
discard granularity and shifting to fs blocks.

Fixes: 076f0faa764ab ("GFS2: Fix FITRIM argument handling")
Signed-off-by: Andrew Price <anprice@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/gfs2/rgrp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1429,7 +1429,8 @@ int gfs2_fitrim(struct file *filp, void
 
 	start = r.start >> bs_shift;
 	end = start + (r.len >> bs_shift);
-	minlen = max_t(u64, r.minlen,
+	minlen = max_t(u64, r.minlen, sdp->sd_sb.sb_bsize);
+	minlen = max_t(u64, minlen,
 		       q->limits.discard_granularity) >> bs_shift;
 
 	if (end <= start || minlen > sdp->sd_max_rg_data)


