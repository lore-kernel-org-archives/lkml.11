Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98E5C32773
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 18:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiHPSZ3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 14:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbiHPSZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278818050B;
        Tue, 16 Aug 2022 11:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B558C61359;
        Tue, 16 Aug 2022 18:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BADAC433D6;
        Tue, 16 Aug 2022 18:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660674325;
        bh=MSXA8SqYd82HZ2Ml/oj0gnasZZGhPAlo30z4TBVFRvI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CA+Hqahc5TVZ74vx5nAyR4P84zMNLWFAI6zfei57WJKmHL/tCaFZokYE2OdfC9KSr
         vDgDyVHbcgm8hSCh6R/uTwo0sbDt6y9TdHBeeaQkXrDbYdFUrFuLvFSOoXu6FCIBUb
         Y17XKABPE0RJYoYSKeiF7Jv/2aNQOlclgNnCHF82OXt6XZHIWM5uZ2cA2+PfMdyMGI
         qXoOB7NAgU7U5FxEF0HwFxxLKkkX/eoGJ2BVRYPmiDq9RxOpFv1YtPj+DBtxfo8mP+
         FxBreldShSCIRCE57KJBM910Ch9ZsmoHf1vCODD1ELn8x600JMO3bR8ABFXuBe2pS4
         VH0udp3Q32biQ==
Date:   Tue, 16 Aug 2022 11:25:22 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Slark Xiao <slark_xiao@163.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= 
        <niklas.soderlund@ragnatech.se>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix incorrect "the the" corrections
Message-ID: <20220816112522.05aac832@kernel.org>
In-Reply-To: <edc5763d90054df7977ae24976e80533c7a1bff9.1660663653.git.geert+renesas@glider.be>
References: <edc5763d90054df7977ae24976e80533c7a1bff9.1660663653.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 17:30:33 +0200 Geert Uytterhoeven wrote:
> Lots of double occurrences of "the" were replaced by single occurrences,
> but some of them should become "to the" instead.
> 
> Fixes: 12e5bde18d7f6ca4 ("dt-bindings: Fix typo in comment")
> 

No empty lines between tags.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Documentation/devicetree/bindings/net/qcom-emac.txt         | 2 +-
> Documentation/devicetree/bindings/thermal/rcar-thermal.yaml | 2 +-

Who takes it then? :S
