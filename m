Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB07C00144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jul 2022 05:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiG2FXW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 01:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiG2FXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 01:23:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D787D1E7;
        Thu, 28 Jul 2022 22:23:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 810F4B826E5;
        Fri, 29 Jul 2022 05:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D25C433C1;
        Fri, 29 Jul 2022 05:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659072198;
        bh=2qGtP/uCnjEbvQmx8cfOGn0284JauFzb6xP2hP9gd0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MDF1jMkQHxB0I1eAEE6KGwlOtjRiJNbxDJFOaOiSMNF64hQtjIdc+amPmRMTkK+ta
         xCqDAS3IkDPYzTgkcdh/nTYdSzQdEOFVwJUV2dbqTb6JeTBhOhcxtYLIbsBvwYVSmF
         44Jmvel6lKPrZieE/skXVg8NL8kaDl5vhkf9ynqSAqPXiywPNWdLmnou//4gUc5VVn
         EW17EEqqaz+RTJK9Bveg6MNts4lfejYYiywtKVQyrc4B8TKoZwSj1n3R2DxKXoX5sY
         4yjM0j5YYE7Q5GyoLxvHRgNbhrysYSdGs9RaZ6DkEfdIjcDBwj5YOP57sAYq39LrSg
         2IUSkR5xU8CuQ==
Date:   Thu, 28 Jul 2022 22:23:16 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: dsa: microchip: KSZ9893: do not write
 to not supported Output Clock Control Register
Message-ID: <20220728222316.1d538cb3@kernel.org>
In-Reply-To: <20220728131852.41518-1-o.rempel@pengutronix.de>
References: <20220728131852.41518-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 15:18:52 +0200 Oleksij Rempel wrote:
> KSZ9893 compatible chips do not have "Output Clock Control Register 0x0103".
> So, avoid writing to it.

Respin will be needed regardless of the answer to Andrew - patch does
not apply.
