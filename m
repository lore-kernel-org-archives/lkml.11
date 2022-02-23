Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFB2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 03:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbiBWDvS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 22:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiBWDvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:51:17 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF23654B0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:50:50 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 47E3D580137;
        Tue, 22 Feb 2022 22:50:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 22 Feb 2022 22:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=3wEKS3h+5OzQyz
        tZqhqo7AqKh3WSzsRZZ2RSeXOn88s=; b=oGxD1TiPv3O+WZnTWLP7nS4c+KwzN6
        v80Ch+fqifCQGX7/8vowCwmdYWC2Wlp/9DKswBjVBZC+HepJqEi2iCnVDewD9lAk
        vPgJSd1waHeTv2Aq+KeQ3qDGj13Sjo6oKMTSSgz1iglHIp20gu/OjjLcaiasAGjm
        z+WRHahkx/Df9RLe1Jalg7PMJ2n11SK+FLHDEyvgRfiyXgtEAbZx3FKQXEiz5wZm
        k0XANgz4VBJqmEZgpGmxgkHI9ObOeVijR+akqGDqL+rjXi2ZF6meNh/S2ZNk78kI
        3ayOQFzotWH9AjnDnB0u7H1gsZllmXqTyHntyV0OXsJNuMs29kcSbogA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=3wEKS3h+5OzQyztZqhqo7AqKh3WSzsRZZ2RSeXOn8
        8s=; b=an0AauzOT8x0/33wVs8WQrTqd1SX7ZQY65KEipZbjjjLROZ2zj6S3n0yz
        y0jXJXnn30lhpzU7z2nOnS2bg0xsmBtor0cx3jwrgbMeLIK7H9YURhTb+YCesNeR
        1wVvmBmUvE5KkUgjGSSAzdzglItZVNE3jVBcNuEd/qR77GZXPbABw/RF5liKpgIZ
        l4bp7XIzxYgSrZIME9rcPnoSHS0IfRDm0+yY4RMM3wF2RpcFjbOpJ+hLouzbzD8h
        dWicgjDTkvcZkiDvstv5OMF3tDiszSGTG84EDNVuXkNdUYWyX3K7g9qTxRqJT86d
        Y5i1xlIOmrUXeTbYbKC7CsX4q8P/A==
X-ME-Sender: <xms:Ga8VYt8ddOy8qX1IarzB4lLVW6_j3YBtY9-5aIBUJZ-2aJWVofkW0Q>
    <xme:Ga8VYhsu0TOVJs8wqv5JvxzltFIR2GhM79inGF6iLagChmIZWDvFfplF94Qa6N9DC
    3YfuoOyJzVm-UyOTA>
X-ME-Received: <xmr:Ga8VYrA7weF-atG8mdGyCtm8OGAp_yWyEEygMdRgwvx2w9SjXgh580EfZYM-HNpxi7Axyj0k6crwEmY-W0GaJU7aNDMujtegWCP5zYmkhQqO4NJUh0ZgyfsV1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuhffvfhfkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduieehveduveejtdfffeetveetfffhjeefheehudehhfdtueehveel
    gfekkeeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:Ga8VYhf2CaY2dVxMEoTiYgPAfNksQeRyRp7a1AJmpc3Eh47M2R3j1g>
    <xmx:Ga8VYiM2zrCUHGyJEnBYSsP87fylsI3uk5AH37PcHbcwXC7vZNqUig>
    <xmx:Ga8VYjkbm09aEYiH5NzwZXQ3Uv9TE9DPdGipa0MAIgW8NPc74I_htQ>
    <xmx:Gq8VYumnZnDnGogVNvwV0M7donP3A8wtvBEso9qqkOmYama8hdSYvA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 22:50:48 -0500 (EST)
Subject: Re: [PATCH v10 13/18] phy: sun4i-usb: Allow reset line to be shared
From:   Samuel Holland <samuel@sholland.org>
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20220211122643.1343315-1-andre.przywara@arm.com>
 <20220211122643.1343315-14-andre.przywara@arm.com>
 <aac11817-5c3c-631e-ad10-0fecf83e4c41@sholland.org>
Message-ID: <562876e1-b14e-a505-5c41-e23b62fa238d@sholland.org>
Date:   Tue, 22 Feb 2022 21:50:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <aac11817-5c3c-631e-ad10-0fecf83e4c41@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On 2/22/22 9:44 PM, Samuel Holland wrote:
> On 2/11/22 6:26 AM, Andre Przywara wrote:
>> The USB HCIs (and PHYs?) in Allwinner's newer generation SoCs (H616)
>> rely on the reset line of USB PHY 2 to be de-asserted, even when only
>> one of the other PHYs is actually in use.
> 
> Thankfully, so far this appears to be a quirk of H616 only.
> 
>> To make those ports work, we include this reset line in the HCIs' resets
>> property, which requires this line to be shareable.

Looking at your .dtsi patch 16/18, you don't actually do this. Is this patch not
needed anymore?

Regards,
Samuel

>> Change the call to allocate the reset line to mark it as shared, to
>> enable the other ports on those SoCs.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Acked-by: Samuel Holland <samuel@sholland.org>
> 

