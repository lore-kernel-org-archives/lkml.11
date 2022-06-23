Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D490BC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 07:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiFWHUj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiFWHUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:20:36 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4614614E;
        Thu, 23 Jun 2022 00:20:35 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DD66622246;
        Thu, 23 Jun 2022 09:20:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1655968833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eKBW9H1ipw5D6InzcUEpxszcfSZjXw6FGB1yyi81oFU=;
        b=GzVxkS+LezyIoK4bXT41RdLKRiHEIEPckWglCQIhmFe+D2lBfKsD8GwugWevlAv7pspQBX
        28M2BdypdCWxfDu5uNWo2NERkFWXS5JH/FkC3Ok7pDWPtmsomoFgeEeEyA1SMKqKfmou9+
        rDszg7QMidQ5PgsEVJXJvrHuN6siCdo=
From:   Michael Walle <michael@walle.cc>
To:     niejianglei2021@163.com
Cc:     andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
        hkallweit1@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        netdev@vger.kernel.org, pabeni@redhat.com,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] net: sfp: fix memory leak in sfp_probe()
Date:   Thu, 23 Jun 2022 09:20:23 +0200
Message-Id: <20220623072023.3637671-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220623070914.1781700-1-niejianglei2021@163.com>
References: <20220623070914.1781700-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>  	err = devm_add_action(sfp->dev, sfp_cleanup, sfp);
> -	if (err < 0)
> +	if (err < 0) {
> +		sfp_cleanup(sfp);
>  		return err;
> +	}

Better use devm_add_action_or_reset(), no?

-michael
