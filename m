Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73143C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 14:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354308AbiDTOuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 10:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242167AbiDTOuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:50:22 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A9E3890;
        Wed, 20 Apr 2022 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=C4GoOKx29HLtanFXK8nyLuAFb7FrVDGEuR4ipZ5/Enk=; b=ggus6FfwcGrUmCEVtuAKjEye7/
        5N4zG6/SklAl7Xs3k2WURX46WMHwO/kQu7K4PLeeV7dbKB5nYQLGG2nUYMiO4A8MEVdilVqAb3HtQ
        rs3BIN6YtUuFHpim+VKPbFV15Kh0rCc71jo/8GhucVlW7Bk1Wq9N1dDFhkWIetFkrNN4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nhBc1-00Gg1E-BS; Wed, 20 Apr 2022 16:47:21 +0200
Date:   Wed, 20 Apr 2022 16:47:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] net: mdio: Mask PHY only when its ACPI node is
 present
Message-ID: <YmAc+dzroa4D1ny2@lunn.ch>
References: <20220420124053.853891-1-kai.heng.feng@canonical.com>
 <20220420124053.853891-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420124053.853891-2-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 08:40:48PM +0800, Kai-Heng Feng wrote:
> Not all PHY has an ACPI node, for those nodes auto probing is still
> needed.

Why do you need this?

Documentation/firmware-guide/acpi/dsd/phy.rst 

There is nothing here about there being PHYs which are not listed in
ACPI. If you have decided to go the ACPI route, you need to list the
PHYs.

	Andrew
