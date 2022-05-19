Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71420C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 17:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242297AbiESRYV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 13:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbiESRYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:24:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89BFA5A8C;
        Thu, 19 May 2022 10:24:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65FBD6172C;
        Thu, 19 May 2022 17:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63BAC385AA;
        Thu, 19 May 2022 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652981051;
        bh=kT8t0KGLk/kGWkkzDUvWH9F3UM1N/oMuLdlF691IFpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZS3TtNgRTSIepBdC9J9Jw5fizX6k9FMaHVxwZFP4is9OjoJdVx+h6F6sy7HhPsHLW
         eEljxdDUKsYPfokPqXPq3BkSY5ydqUzi15yPi/mYsEQTyMDNvDJphFTA5tw63ESgrh
         HOClkB2nQMjXDMUQ09DI4HfRwNiPeryx6hdVlopcp3nH/7M+zj5vjwLyTr/b1TK5OB
         g6+0hlWBeyJBFZVEWwz45FU+yCB/eakX+uq0FWdVMg/q5RTJz9lwhNbd8dZLhQRfsT
         6zN4Qsggu9ZBQeo4LtJoXMtLKyaiF2o5Vb9P/qcDvfnsrHr1VX18gSP3eos0uO+AFk
         XepqzOkKIvT/A==
Date:   Thu, 19 May 2022 22:54:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] dmaengine/ARM: pxa/mmp: use proper
 'dma-channels/requests' properties
Message-ID: <YoZ9Ng4RmcMrnd2o@matsya>
References: <20220503065407.52188-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503065407.52188-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-05-22, 08:54, Krzysztof Kozlowski wrote:
> Hi,
> 
> The core DT schema defines generic 'dma-channels' and 'dma-requests'
> properties, so in preparation to moving bindings to DT schema, convert
> existing users of '#dma-channels' and '#dma-requests' to the generic
> variant.

Applied 1-3, thanks

-- 
~Vinod
