Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45026CCA47B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 12:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiGEM3Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 08:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbiGEMTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD9C1D30E;
        Tue,  5 Jul 2022 05:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46A8461A40;
        Tue,  5 Jul 2022 12:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555A1C341CE;
        Tue,  5 Jul 2022 12:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657023302;
        bh=B9lGsTO8+rd4ywDVb/7Swp87LvTfNxatEG6Gl7sn4bY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jg0hPU/r/x7hZwT0dL+lXPytSVuBpV7e76IeLoic/55CWcogfaMpwGflddp48fibQ
         GjJeMcjOqyPASC9zrgB8w783i1rSxTaW7b7/rZyakoLp3ItwvNSIhwkx7pfPmMmzC7
         3mjAVJKtVukEdEEtJeOhs/SvX5xRhTAUPnaHAJZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Ye <chris.ye@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 5.18 012/102] nvdimm: Fix badblocks clear off-by-one error
Date:   Tue,  5 Jul 2022 13:57:38 +0200
Message-Id: <20220705115618.764154195@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705115618.410217782@linuxfoundation.org>
References: <20220705115618.410217782@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Ye <chris.ye@intel.com>

commit ef9102004a87cb3f8b26e000a095a261fc0467d3 upstream.

nvdimm_clear_badblocks_region() validates badblock clearing requests
against the span of the region, however it compares the inclusive
badblock request range to the exclusive region range. Fix up the
off-by-one error.

Fixes: 23f498448362 ("libnvdimm: rework region badblocks clearing")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chris Ye <chris.ye@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Link: https://lore.kernel.org/r/165404219489.2445897.9792886413715690399.stgit@dwillia2-xfh
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvdimm/bus.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -182,8 +182,8 @@ static int nvdimm_clear_badblocks_region
 	ndr_end = nd_region->ndr_start + nd_region->ndr_size - 1;
 
 	/* make sure we are in the region */
-	if (ctx->phys < nd_region->ndr_start
-			|| (ctx->phys + ctx->cleared) > ndr_end)
+	if (ctx->phys < nd_region->ndr_start ||
+	    (ctx->phys + ctx->cleared - 1) > ndr_end)
 		return 0;
 
 	sector = (ctx->phys - nd_region->ndr_start) / 512;


