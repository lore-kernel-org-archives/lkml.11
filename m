Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A021C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 14:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiCQO0Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 10:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbiCQO0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:26:21 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B672185463;
        Thu, 17 Mar 2022 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=mVofJu7F0KFyAXf7VtVchEN8qlIRqXJCebogLkRenfM=; b=sRmYEEvQzbaWpKijO9VMvwzsLt
        bDvU7NfkXMdvbCf38TaeXauuh+29cZwwYQNhTUemdqKBRyVcJtkHnOfFts9r3FWKjk9JdM5/5B81i
        b2zM2L4DOwCsG4nLN8PDEEQ9t/L6TdhMAIsZI90oG4QdZLzQvYw441QzH33t4/roDz/k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nUr3k-00BQJC-VX; Thu, 17 Mar 2022 15:25:00 +0100
Date:   Thu, 17 Mar 2022 15:25:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: irqchip: mrvl,intc: refresh maintainers
Message-ID: <YjNEvKTrLXv3/9nL@lunn.ch>
References: <20220317120252.451669-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317120252.451669-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:02:52PM +0100, Krzysztof Kozlowski wrote:
> Jason's email bounces and his address was dropped from maintainers in
> commit 509920aee72a ("MAINTAINERS: Move Jason Cooper to CREDITS"), so
> drop him here too.  Switch other maintainers from IRQCHIP subsystem
> maintainers to Marvell Orion platform maintainers because its a bigger
> chance they know the hardware.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Sebastian has not contributed for a long time. So i suggest you only
add Gregory and myself.

   Andrew
