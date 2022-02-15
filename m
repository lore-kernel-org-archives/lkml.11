Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE576C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 11:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbiBOLXx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 06:23:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiBOLXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:23:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32252108199;
        Tue, 15 Feb 2022 03:23:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2F26614C4;
        Tue, 15 Feb 2022 11:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60690C340EB;
        Tue, 15 Feb 2022 11:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644924221;
        bh=Up9ehlKx74egghlc0rB6/0cz+lxVqCHj3ODYTFsP8Us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=upt4svaU5dIOhZX91oIKAkRPWYXkZB3CmdnRMdOLEQfr2y0cfduw0GPzNDH/vrOA4
         YP7se29FEDVYKtTjMSbIY8FwEoGgviCeMG89monmth4UUljTX9mAlxwFcWXoL/h/fq
         4KB/18MYOVflHmylw6tS4NiTgVDRWx6VCk+nxFLuJogOihcPXC7T+o5bukn2MzHd6z
         TejCCtDrCvlAX5FLfUiqNBPKhUdASAgWGSYZ320pE83/byIdbpzzcYu8NOWU99Ky6T
         QtJvqK7EkGKH31/hADj0nBkI5sbh2PsaFbzAq2jmglTCfg8i9J8CNbfsvQXWPfPcSg
         1yK7m0LkVIMSw==
Date:   Tue, 15 Feb 2022 16:53:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        Stefan Roese <sr@denx.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: altera-msgdma: Remove useless DMA-32 fallback
 configuration
Message-ID: <YguNOAAqMo1G0exC@matsya>
References: <01058ada3a0dea207212182ca7525060a204f1e1.1642232423.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01058ada3a0dea207212182ca7525060a204f1e1.1642232423.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-01-22, 08:40, Christophe JAILLET wrote:
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.

Applied, thanks

-- 
~Vinod
