Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EE4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 13:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354213AbiBNNVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 08:21:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiBNNVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:21:20 -0500
X-Greylist: delayed 311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 05:21:12 PST
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7126A483BF;
        Mon, 14 Feb 2022 05:21:12 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E97D86BF; Mon, 14 Feb 2022 14:21:10 +0100 (CET)
Date:   Mon, 14 Feb 2022 14:21:09 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, ~okias/devicetree@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/msm: simplify with dev_err_probe()
Message-ID: <YgpXRQ9KJrgJ+Cwc@8bytes.org>
References: <20220206202945.465195-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206202945.465195-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 09:29:45PM +0100, David Heidelberg wrote:
> Use the dev_err_probe() helper to simplify error handling during probe.
> This also handle scenario, when EDEFER is returned and useless error is
> printed.
> 
> Fixes warnings as:
> msm_iommu 7500000.iommu: could not get smmu_pclk
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/iommu/msm_iommu.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)

Applied, thanks.
