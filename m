Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D04C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 04:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiBVECZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 23:02:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBVECT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 23:02:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54BF3135C;
        Mon, 21 Feb 2022 20:01:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31BF4B81851;
        Tue, 22 Feb 2022 04:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81FAC340E8;
        Tue, 22 Feb 2022 04:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645502498;
        bh=+YrMSPDyIBd73yuuFazYh2T7Cw/wvs931utX9SkopcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tEE+BdTqnz+YKZ0D0ACZ+ckqK2dHio40tIWT/GjuMik+vFxbBrEacN4jKCwmM547r
         edGtr2FKqKskz3NBwZ65NRrC1SRPfw3HB4FFPKPg03qdzFEV2WCqkEMD8esGXeA0yR
         FOB6C8aKVBIuv5nmh58+d3mPnGX/odBvanS5PruxVABZR58L2HCrZDp6WeujhEn6/3
         4VnsQSTPoZkEkIejLHCx/4abAjdKIp+C7fblvYgAwRa1++IsTtiAlGSPfu3BF6eG2s
         1QynUr4SKf7jpK4B2X4s0CEHx19ogzmAZZ2JnCnF14CWCdnyCGzK1Gqjmgs/uuJmy4
         T5twrxfxz801g==
Date:   Tue, 22 Feb 2022 09:31:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: mdt_loader: Fix split-firmware condition
Message-ID: <YhRgHgp7dUkQ1+AB@matsya>
References: <20220215034819.1209367-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215034819.1209367-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-02-22, 19:48, Bjorn Andersson wrote:
> The updated condition checking if a segment can be found in the loaded
> firmware blob, or need to be loaded from a separate file, incorrectly
> classifies segments that ends at the end of the loaded blob. The result
> is that the mdt loader attempts to load the segment from a separate
> file.
> 
> Correct the conditional to use the loaded segment instead.
> 
> Fixes: ea90330fa329 ("soc: qcom: mdt_loader: Extend check for split firmware")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
