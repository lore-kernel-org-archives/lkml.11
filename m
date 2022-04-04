Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA48BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 12:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243329AbiDDMYm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 08:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiDDMYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:24:40 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2556C22B39;
        Mon,  4 Apr 2022 05:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=0V7pVZcqfS3nz3f+PXRFZmM5UFJ67EOIx9GPX4S4NwU=; b=MN
        wxwn1P9p93bvJ8c2xN8QitjFJRcOd2vJTD68CqnU7FfDF4VjlDwh81DziVM5mbv7tq++MVQ8vmzA6
        5a9dh7SrV/iYdPhYJ1XzZHcvnXh3so0LKXKs7iaLJ6qc7Rme0b/a6CgMjEm5WLlBnw5PmtvnvWQWa
        cdGtHw3pk+Xgrug=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nbLio-00E5S1-Mj; Mon, 04 Apr 2022 14:22:14 +0200
Date:   Mon, 4 Apr 2022 14:22:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>
Subject: Re: [PATCH] net: ethernet: mtk_eth_soc: add label support for GMACs
Message-ID: <Ykri9tOtUDmXzHkG@lunn.ch>
References: <20220404114000.3549-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220404114000.3549-1-arinc.unal@arinc9.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 02:40:00PM +0300, Arınç ÜNAL wrote:
> From: René van Dorst <opensource@vdorst.com>
> 
> Add label support for GMACs. The network interface of the GMAC will have
> the string of the label property defined on the devicetree as its name.

Sorry, but no. This has been discussed a few times, you need something
in user space, udev or systemd etc to set interface names.

Please look back in the archive at previous discussions.

   Andrew
