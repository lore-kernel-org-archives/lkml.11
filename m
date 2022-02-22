Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB75C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 05:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiBVFXX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 00:23:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBVFXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:23:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA5EB6D14;
        Mon, 21 Feb 2022 21:22:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31795B81754;
        Tue, 22 Feb 2022 05:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A35C340EB;
        Tue, 22 Feb 2022 05:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645507357;
        bh=KCTcj5TseEAUcvGzo4Wj0gTwBw0tNSSMLCB6TBjzO/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqfBCdQOkblPXZ0t5+y1SjzzAmAVZVBfCOTxiJf/NnYx0y5GvX6M/ehX0FfBLcx4q
         FuYsgSjAnhdtAsrz0AmhKXDaZAavMCrlofIA8jLaDlJNXXTec4f5SCq3gquAHD+gHi
         TH9S1846C1rPAgxCUYSdLQFonpTgfuAwRjBvoYQH0Zog5bfZKtSh5/cYBPnaQLUm9I
         JdS9iWejT/tePeno6otX6673OFB1pNZqW/HV91nxiDxZv8ic5cru1DjijVQyHRGnUX
         z9nCp2CdZk3QX+1m+uZHyGfddMHFtCKOGPJEyCMRdrzvEHFqinQIzg4SrE9fqbu7SV
         GC11hcpIgnzMw==
Date:   Tue, 22 Feb 2022 10:52:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: update Roger Quadros email
Message-ID: <YhRzGbSHLrDwxxSm@matsya>
References: <20220221100701.48593-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221100701.48593-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-22, 11:07, Krzysztof Kozlowski wrote:
> Emails to Roger Quadros TI account bounce with:
>   550 Invalid recipient <rogerq@ti.com> (#5.1.1)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Roger,
> You should also add a mailmap entry for your inactive emails.
> 
> Best regards,
> Krzysztof
> ---
>  .../devicetree/bindings/mfd/ti,j721e-system-controller.yaml     | 2 +-
>  Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml         | 2 +-

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
