Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1D3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 15:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356955AbiFNPiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 11:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbiFNPiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:38:24 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0399613D3C;
        Tue, 14 Jun 2022 08:38:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1655221096; bh=RmavVAoVYeGxudvyKfhDPXiP4081rt8/4kJVo2A95ck=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=CJuud0WPMFwl+lsLOeGuCnvxRKYRyja73F9uU9itkZOXdV46hNuVD+kNR92io3RhB
         H6pU7s/V9DJGaGPisvuSVtyviH1WiZkFQiStfyFUPkpJ3n5V9PdeF7AED/GP9Q4L6t
         U+sipF4LUfVPAmJ+dPNHuCKPfGicu/kszNyZhnMw=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] dt-bindings: dma: apple,admac: Fix example interrupt
 parsing
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20220614152503.1410755-1-robh@kernel.org>
Date:   Tue, 14 Jun 2022 17:38:15 +0200
Cc:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6F273631-05A0-4766-BB5D-BD056D1BFEDB@cutebit.org>
References: <20220614152503.1410755-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 14. 6. 2022, at 17:25, Rob Herring <robh@kernel.org> wrote:
>=20
> Commit 873971f8fb08 ("dt-bindings: dma: Add Apple ADMAC") has a =
warning
> in its example:
>=20
> Documentation/devicetree/bindings/dma/apple,admac.example.dtb: =
dma-controller@238200000: interrupts-extended: [[0], [4294967295, 0, =
626, 4, 0, 0]] is too short
> 	=46rom schema: =
/builds/robherring/linux-dt/Documentation/devicetree/bindings/dma/apple,ad=
mac.yaml
>=20
> The problem is the number of interrupt cells can't be guessed when
> there are empty '0' entries. So the example must have a valid =
interrupt
> controller defining the number of interrupt cells.
>=20
> Fixes: 873971f8fb08 ("dt-bindings: dma: Add Apple ADMAC")
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks,

Acked-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>

