Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A1DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 07:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiE3HGb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 03:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiE3HG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:06:29 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E187F71A06
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:06:28 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AFD081C0B8A; Mon, 30 May 2022 09:06:27 +0200 (CEST)
Date:   Mon, 30 May 2022 09:06:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, joel@jms.id.au, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v7 1/8] ARM: hpe: Introduce the HPE GXP architecture
Message-ID: <20220530070626.GD1363@bug>
References: <20220506191339.78617-1-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506191339.78617-1-nick.hawkins@hpe.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP is the HPE BMC SoC that is used in the majority
> of current generation HPE servers. Traditionally the asic will
> last multiple generations of server before being replaced.
> 
> Info about SoC:

Normally, 1/7 goes into the same thread as 0/7 mail.

Best regards,
									Pavel
