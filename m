Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2A7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 07:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbiDRHU6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 03:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiDRHUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 03:20:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7EB17045;
        Mon, 18 Apr 2022 00:18:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B93C46101C;
        Mon, 18 Apr 2022 07:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2B5C385A1;
        Mon, 18 Apr 2022 07:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650266297;
        bh=RwhFtkKG6dFDM0+nlftl7vADhCVFhPLd3YRxCHWiNJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HN2Jm9AKPTzqpSz7QACS2HIEXpumq8UJ06UjBOGoQwMJCpF4k1+/AUAvTL7nXjAn1
         H09FcGFBuLNGy5xNZ0xe43tHRxpUWVBFDeiPOVy+dkIv9HPzxTeuSNdFjGfYBnAKkR
         9+4mS2v9KmwxE+qTS8UKAWX6VZT0SqhXgzV0bI5orOWGdF1iPv/Vdl8NtfqSNHkb8z
         nzVueFiZFD3bs0BwEDFFWf5sDoq+1KgU0hnQqkNd/n85gFjJXcQx0e4T/k7p7C3oVI
         Y2Jug9VZ8dItgHu8bbWcXjod8X20tRgnA8aZS1CpUIiYSFrHt7C+/sMnns2h9KVRt6
         rDd9ODwW85UYA==
Date:   Mon, 18 Apr 2022 12:48:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8350: Define GPI DMA engines
Message-ID: <Yl0QtdTUkFy6k9U4@matsya>
References: <20220412215137.2385831-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412215137.2385831-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-04-22, 14:51, Bjorn Andersson wrote:
> The Qualcomm SM8350 has three GPI DMA engines, add definitions for
> these.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
