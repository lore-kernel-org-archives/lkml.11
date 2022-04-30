Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D69DC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Apr 2022 02:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382057AbiD3CJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Apr 2022 22:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240255AbiD3CJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 22:09:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF7E9A995;
        Fri, 29 Apr 2022 19:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC88562484;
        Sat, 30 Apr 2022 02:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7439C385A7;
        Sat, 30 Apr 2022 02:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651284384;
        bh=SXW+S2HTZFqa7k53eM06jQdKyJ9zaWGvT+IRJEffFQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VBAEFr2tQZMDyQBU6K21bSECYwJw6gN7Ea+/bJ7WJRTapenmE8HEMAsffMSh4+tIW
         YuYiGmwEqcH/2RXfk88sDfhWWWy4lYd0njfMTDBHZkHRmuXwLIIEbjJHZ/1aHiP+/q
         zOK3pDmLlyJvH9T0B0RxYrycTvebiCnYngrXFrxOt85GRmLigvN0mqXfkbKVDi8frj
         MYc1w980iJTM95ktWPsBS3ibxwG26WPFnD8Z6Ogw9JAS/WcOgkHKAcMIr+2+lnxrax
         /7yCs72Wf0m3T6YByOw0PRWxIm15D+H4jD+ln9+B4z2GZuryxXUbq7oOZzsdjwmrUi
         /2k85WEqJbiWA==
Date:   Fri, 29 Apr 2022 19:06:22 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v1 net 2/2] net: mscc: ocelot: fix possible memory
 conflict for vcap_props
Message-ID: <20220429190622.6f5279b8@kernel.org>
In-Reply-To: <20220429233049.3726791-3-colin.foster@in-advantage.com>
References: <20220429233049.3726791-1-colin.foster@in-advantage.com>
        <20220429233049.3726791-3-colin.foster@in-advantage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 16:30:49 -0700 Colin Foster wrote:
> Fixes: 2096805497e2b ("net: mscc: ocelot: automatically detect VCAP
> constants")
> 
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>

Please don't line-wrap tags and please don't add empty lines between
them. Let's give Vladimir a day or two to comment on the merits and
please repost with the tags fixed, thanks!
