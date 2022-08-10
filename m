Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C342C00140
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 11:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiHJLQu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 07:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHJLQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:16:41 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9266D6E2FD
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:16:39 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4DEDB221D4;
        Wed, 10 Aug 2022 13:16:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1660130197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/4hxjgjKxtFgmOjAlVBuhAWdftUHJxsQZr4jGqnqnU=;
        b=nGJCXaGdjebn5STL0n0smTYnxJ/gwGLHMwcblk3Jaa/MJ7AdlWCw2hYDB4lOXjLv+dEgQB
        fZKgWXWRvF+c64F8IlZI3wF4ZZe8TdJE/IZ+Ce4NgQSLDN4CC3kXvqCTe0rYYRmSMU73Ei
        6inR2f/Y2S7R7Kx7IJb+OpRF3qvjSlg=
From:   Michael Walle <michael@walle.cc>
To:     f.fainelli@gmail.com
Cc:     conor.dooley@microchip.com, gregkh@linuxfoundation.org,
        ionela.voinescu@arm.com, linux-kernel@vger.kernel.org,
        rafael@kernel.org, sudeep.holla@arm.com,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] arch_topology: Silence early cacheinfo errors when non-existent
Date:   Wed, 10 Aug 2022 13:16:30 +0200
Message-Id: <20220810111630.1248499-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220805230736.1562801-1-f.fainelli@gmail.com>
References: <20220805230736.1562801-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Architectures which do not have cacheinfo such as ARM 32-bit would spit
> out the following during boot:
> 
>  Early cacheinfo failed, ret = -2
> 
> Treat -ENOENT specifically to silence this error since it means that the
> platform does not support reporting its cache information.
> 
> Fixes: 3fcbf1c77d08 ("arch_topology: Fix cache attributes detection in the CPU hotplug path")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
Tested-by: Michael Walle <michael@walle.cc>

-michael
