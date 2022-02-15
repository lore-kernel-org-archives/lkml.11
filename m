Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5C2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 05:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiBOFSA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:18:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiBOFR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:17:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CAB95491;
        Mon, 14 Feb 2022 21:17:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E899B817B0;
        Tue, 15 Feb 2022 05:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798F4C340EC;
        Tue, 15 Feb 2022 05:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644902265;
        bh=llfRZiS0nJDKckZ14/zXDlzRmqfPP6XX4LcakrfbBOg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LMlOsBVEr6D0Df7KS6ZUmW+EzpCNdalIPA323SnSZ+MgqIVv5GuvF/i0lGwv42uYs
         /QOZ5lLjelas5vVVWHoyA8x8xiJxHJTS6zq1h3xVWI0ngWO1jmFvlWDXayBlS7DjNF
         cGjxXyNm1avavzhu3071BtIGRYywyVkReO9FwhY2cTNwmvi7XTmOqyse7pDq19Obnp
         gFUZN2ShKEZEFJtgq3jTtHvZYTxIuo5v12I4YOYtrxFAJ4O+X9sAzwEi7Qe5cHW6R7
         HVrwQy+gAI8PNnsUN5hhINNb2Mjr6gGHNPT6i99R4MZmRuaqkYlu91ustfER0jnrsk
         qu0W+QONAUW8Q==
Date:   Mon, 14 Feb 2022 21:17:43 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yevhen Orlov <yevhen.orlov@plvision.eu>
Cc:     netdev@vger.kernel.org,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Mickey Rachamim <mickeyr@marvell.com>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>,
        Taras Chornyi <tchornyi@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Andrii Savka <andrii.savka@plvision.eu>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: marvell: prestera: Fix includes
Message-ID: <20220214211743.6fbd3075@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220214011228.5625-1-yevhen.orlov@plvision.eu>
References: <20220214011228.5625-1-yevhen.orlov@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 03:12:28 +0200 Yevhen Orlov wrote:
> Include prestera.h in prestera_hw.h, because it may contain common
> definitions.

*May*? Is prestera_hw.h using definitions from prestera.h today?
Dependencies between header files are best avoided completely.
