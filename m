Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C67C433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Apr 2022 14:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiDPOeU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Apr 2022 10:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiDPOeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 10:34:19 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CDD49698;
        Sat, 16 Apr 2022 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=GxpdlfRZGzRYx2zB4wxOajCp/JnYMCfdzjc5G/Q7TvQ=; b=p0LG1DNzvpCH3NV1RxgeVU1PSv
        0Au2XgCIgMtlS7XkBxQAuabLieY0ThMChQtROFe3KUhLfAeZgMJlHeb7aVYGLAo6TB0jlFJPwjwg0
        KvvBxkffs8h5vWPbxmpaKL6gBEpna6UsRQZzWlAx0sjC12yb/834mMcwoklptiGFGXvQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nfjSd-00G6xx-E8; Sat, 16 Apr 2022 16:31:39 +0200
Date:   Sat, 16 Apr 2022 16:31:39 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 3/4] drivers: net: dsa: qca8k: rework and
 simplify mdiobus logic
Message-ID: <YlrTS7IDo1m32S36@lunn.ch>
References: <20220412173019.4189-1-ansuelsmth@gmail.com>
 <20220412173019.4189-4-ansuelsmth@gmail.com>
 <20220414140823.btcvlebraynaw6wr@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414140823.btcvlebraynaw6wr@skbuf>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Does the MDIO bus id constitute unbreakable ABI? I hope not, otherwise
> as you say, we couldn't support multiple switches.

In theory yes, but in practice i doubt it is. I would suggest you make
the change. If we get a report of a regression, then we can think
about it some more.

      Andrew
