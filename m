Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C85CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 05:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiGFFpY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 01:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiGFFpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 01:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F9621E10;
        Tue,  5 Jul 2022 22:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10FFF61CEE;
        Wed,  6 Jul 2022 05:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99381C3411C;
        Wed,  6 Jul 2022 05:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657086320;
        bh=3D6JnTyqnPP2jiPpHSlGQDcx4nSOuFUKoMkf/By5jzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=beHWBKQE3jSY94shQkm5jd1+RuTdBb2ueweYw6N0sIMjpCw2iwAnt8svfD5/V1CtD
         +vfgei5ddElQG65X38w3m5VNNcfCgo93Bxb9axxKSjaZrjE1ecnx67Gne94S1fa7jc
         wCrKVt0N9qXQAmLWQyTSdhELrOsNNpHSnPVlYEKGNE7Ha10OJunLksj9WryWN3ijBE
         ywM0gzVZ+2vvLmJJwJaquNZXVnS5i2rFXFTdSnvcIP8HVrRhMVJBBqY7txkB5zrP7B
         3FpKbIw7odrseCf9io6Ui7Jc+cDP1wMWpf4ONB+s6Vto9h3LgpizR6VrjUSLAufLYC
         xHpUiJRr4WxMw==
Date:   Wed, 6 Jul 2022 11:15:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 03/13] dt-bindings: dma: dw-axi-dmac: extend the
 number of interrupts
Message-ID: <YsUhbD0zJk43/4oa@matsya>
References: <20220705215213.1802496-1-mail@conchuod.ie>
 <20220705215213.1802496-4-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705215213.1802496-4-mail@conchuod.ie>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-22, 22:52, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The Canaan k210 apparently has a Sysnopsys Designware AXI DMA
> controller, but according to the documentation & devicetree it has 6
> interrupts rather than the standard one. Support the 6 interrupt
> configuration by unconditionally extending the binding to a maximum of
> 8 per-channel interrupts thereby matching the number of possible
> channels.

Applied, thanks

-- 
~Vinod
