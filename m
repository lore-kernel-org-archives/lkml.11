Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6C0C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 23:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351817AbiC3XbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 19:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347974AbiC3XbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:31:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B8327B28
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:29:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id EBAFA1F46057
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648682962;
        bh=2Aw59J1GMFNx5W0R3ALTAtEuLxi4M5bwfjRhWuhb7CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TVSCUvG6BhBxf3w4gp8U+feiK3EkK70kObxUTlaxb2xQVluRaXmi/y/hLQ339geZ1
         QqYcTFAAsY/lVTIL/sdmD1W3y0Mp3zj4+VfKvtij9HBU8061fpkCFIixRD+QjAQu4S
         N1KDDEdg44pTf73esJyoqXXepcu0i/anBeuYsrYgXVZ6o844Dy6zNXTx+RwmQiAcTS
         DJi4iMlzN4gIoOtBvTtStVOOrmiFXwNWu6efyM23eECPNumpcreR87W+2bJs8ks4rd
         4X9m+85LRJpClzB44uaiuFwNFCbmEBsU2oRblsgP0IscHw5pl2i1zILhjheOSfNMCe
         OwxccEyp5um6g==
Date:   Wed, 30 Mar 2022 19:29:17 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] soc: mediatek: pwrap: Use readx_poll_timeout()
 instead of custom function
Message-ID: <20220330232917.uu7337hv6dqh34xv@notapiano>
References: <20220329152245.124341-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220329152245.124341-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Tue, Mar 29, 2022 at 05:22:43PM +0200, AngeloGioacchino Del Regno wrote:
> @@ -1303,7 +1297,8 @@ static int pwrap_read32(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>  		pwrap_writel(wrp, ((msb << 30) | (adr << 16)),
>  			     PWRAP_WACS2_CMD);
>  
> -		ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_vldclr);
> +		ret = readx_poll_timeout(pwrap_is_fsm_idle, wrp, tmp, tmp,

Should be pwrap_is_fsm_vldclr.

Thanks,
Nícolas

> +					 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
>  		if (ret)
>  			return ret;
>  
