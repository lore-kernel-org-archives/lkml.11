Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EF7C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 20:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiGYUJ7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiGYUJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:09:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8D220F6F;
        Mon, 25 Jul 2022 13:09:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F35FAB80E01;
        Mon, 25 Jul 2022 20:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDEEC341C6;
        Mon, 25 Jul 2022 20:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658779793;
        bh=aOWZyTMoZqC2ZWZclAC30+8dvahXkYEp83QRpZBiuMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uNJP4yakkas6CrGGRq0V3/Q/N8inFIzrkxhuU2Ns+m0tOSZ25/LKcIu+iTZDBaUpR
         JFhRFcP/ZM3OzWYmOCBHFW9/eirYEPQrxEJ/MDZudpa49GMbRFs0MktJl/fF6Se5cI
         WEIMl0D/aw2pcbkTB3tAMHbc9QDgzBz+yElFHzVFbJxrPc58GDnZ21FVbYx43U2zUY
         AkRtdmQw4xKu7frqdms5pw2Hvwsi9jSgLXlwIxmsW55fTqMr2PAJNmEnSQWSJ9n8it
         GFgUKFL7s7NA+MH6a2JFekcZo6ZZI4hLqIdMYtFo/S4+O8Vyw0dTguSsD78Y5aFawb
         cIVhZGx/iKJ4A==
Date:   Mon, 25 Jul 2022 13:09:52 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Camelia Groza <camelia.groza@nxp.com>,
        linux-kernel@vger.kernel.org (open list),
        Madalin Bucur <madalin.bucur@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 00/25] net: dpaa: Cleanups in preparation for phylink
 conversion
Message-ID: <20220725130952.657626d4@kernel.org>
In-Reply-To: <20220725151039.2581576-1-sean.anderson@seco.com>
References: <20220725151039.2581576-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 11:10:14 -0400 Sean Anderson wrote:
> This series contains several cleanup patches for dpaa/fman. While they
> are intended to prepare for a phylink conversion, they stand on their
> own. This series was originally submitted as part of [1].

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#tl-dr
