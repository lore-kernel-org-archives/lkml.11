Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD644C41535
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 22:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444004AbiDEWU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 18:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbiDEKcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:32:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 453B42252F;
        Tue,  5 Apr 2022 03:18:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B709D6E;
        Tue,  5 Apr 2022 03:18:31 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 971AA3F5A1;
        Tue,  5 Apr 2022 03:18:28 -0700 (PDT)
Message-ID: <00bcebba-4955-cbbd-e7f4-e344f9b932a0@arm.com>
Date:   Tue, 5 Apr 2022 11:18:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/msm: use orig_nents to iterate over scatterlist with
 per-process tables
Content-Language: en-GB
To:     Jonathan Marek <jonathan@marek.ca>, freedreno@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>, dpiliaiev@igalia.com,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>,
        open list <linux-kernel@vger.kernel.org>
References: <20220328125505.31605-1-jonathan@marek.ca>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220328125505.31605-1-jonathan@marek.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-28 13:55, Jonathan Marek wrote:
> This matches the implementation of iommu_map_sgtable() used for the
> non-per-process page tables path.
> 
> This works around the dma_map_sgtable() call (used to invalidate cache)
> overwriting sgt->nents with 1 (which is probably a separate issue).

FWIW that's expected behaviour. The sgtable APIs use nents to keep track 
of the number of DMA segments, while orig_nents represents the physical 
segments. IIUC you're not actually using the DMA mapping, just relying 
on its side-effects, so it's still the physical segments that you care 
about for your private IOMMU mapping here.

> Fixes: b145c6e65eb0 ("drm/msm: Add support to create a local pagetable")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>   drivers/gpu/drm/msm/msm_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index bcaddbba564df..22935ef26a3a1 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -58,7 +58,7 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
>   	u64 addr = iova;
>   	unsigned int i;
>   
> -	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> +	for_each_sg(sgt->sgl, sg, sgt->orig_nents, i) {

Even better would be to use for_each_sgtable_sg(), which exists 
primarily for the sake of avoiding this exact confusion.

Robin.

>   		size_t size = sg->length;
>   		phys_addr_t phys = sg_phys(sg);
>   
