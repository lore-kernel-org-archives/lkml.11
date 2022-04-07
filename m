Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE21C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 16:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345675AbiDGQTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 12:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345668AbiDGQTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:19:13 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0741E7464;
        Thu,  7 Apr 2022 09:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=MWMYUvxxQQl/e+7TuhjQmN5IAfBuJmlz8AgqJFrsH/c=; b=yds/9JiPwd9ffHz9HM5fkQNGzw
        2hOLVRjwJBMDkFbVnaIQ2EZBWtYRgvuHQmCmu3LQQY0X77m23scuTVKQgEfeQN1BIjXMh+KsVZ5vD
        DYoIjmHbQlZWXMl3sy0ZvMhVNZbvomXzEyXUYF31HCFLQnQNkvvHY/wW0d7K/NmM2Jkc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ncUPO-00Efak-3f; Thu, 07 Apr 2022 17:50:54 +0200
Date:   Thu, 7 Apr 2022 17:50:54 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/14] dt-bindings: arm: mediatek: document WED
 binding for MT7622
Message-ID: <Yk8IXno6sjkHVf4g@lunn.ch>
References: <20220405195755.10817-1-nbd@nbd.name>
 <20220405195755.10817-5-nbd@nbd.name>
 <d0bffa9a-0ea6-0f59-06b2-7eef3c746de1@linaro.org>
 <e3ea7381-87e3-99e1-2277-80835ec42f15@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3ea7381-87e3-99e1-2277-80835ec42f15@nbd.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Isn't this a network offload engine? If yes, then probably it should be
> > in "net/".
> It's not a network offload engine by itself. It's a SoC component that
> connects to the offload engine and controls a MTK PCIe WLAN device,
> intercepting interrupts and DMA rings in order to be able to inject packets
> coming in from the offload engine.

Hi Felix

Maybe turn the question around. Can it be used for something other
than networking? If not, then somewhere under net seems reasonable.

     Andrew
