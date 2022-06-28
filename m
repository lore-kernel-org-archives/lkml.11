Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18780C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 06:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343580AbiF1Gfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 02:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245747AbiF1Gf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:35:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FBF27CC5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43C16B81B97
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE36C3411D;
        Tue, 28 Jun 2022 06:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656398078;
        bh=YH4oxZVzU+FrY2eMW2RZbmu5DK/XM5uHJX0XVuT98EA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4EzBVx6oGk3IYWM0hyDpQmAngtgmZspK9bXIi1OMSMgdq+g1VoR1dH8nDMLPYarW
         3bPU/0EWMQqKH3ZR/6G7YdkIGB249G6TccQb4TMVpyOZDpBaMyhsVEnLLX8jdalUWf
         evCIzVe5oUIVdk/4OcC+z7ARd8VjsEBrJMM6nvBM=
Date:   Tue, 28 Jun 2022 08:34:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] habanalabs: add unsupported functions
Message-ID: <Yrqg+6bBxRMmomrm@kroah.com>
References: <20220627202620.961350-1-ogabbay@kernel.org>
 <20220627202620.961350-5-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627202620.961350-5-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 11:26:12PM +0300, Oded Gabbay wrote:
> There are a number of new ASIC-specific functions that were added
> for Gaudi2. To make the common code work, we need to define empty
> implementations of those functions for Goya and Gaudi.
> 
> Some functions will return error if called with Goya/Gaudi.
> 
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 24 ++++++++++++++++++++++++
>  drivers/misc/habanalabs/goya/goya.c   | 24 ++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index ae894335e9f8..f4581220ecd5 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -8588,6 +8588,11 @@ static void gaudi_ctx_fini(struct hl_ctx *ctx)
>  	gaudi_internal_cb_pool_fini(ctx->hdev, ctx);
>  }
>  
> +int gaudi_pre_schedule_cs(struct hl_cs *cs)
> +{
> +	return 0;
> +}
> +
>  static u32 gaudi_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
>  {
>  	return gaudi_cq_assignment[cq_idx];
> @@ -8959,6 +8964,14 @@ static void gaudi_enable_events_from_fw(struct hl_device *hdev)
>  		gaudi_irq_map_table[GAUDI_EVENT_INTS_REGISTER].cpu_id);
>  }
>  
> +int gaudi_ack_mmu_page_fault_or_access_error(struct hl_device *hdev,
> +							u64 mmu_cap_mask)
> +{
> +	dev_err(hdev->dev, "mmu_error function is not supported\n");

Can userspace trigger this?  if so, make it debug, as you don't want to
give userspace a way to spam the logs.

thanks,

greg k-h
