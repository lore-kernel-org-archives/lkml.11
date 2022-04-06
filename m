Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA4DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 14:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiDFOTo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiDFOSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:18:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAFF194AA4;
        Tue,  5 Apr 2022 19:15:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB1CBB81FB2;
        Wed,  6 Apr 2022 02:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4C4C385A1;
        Wed,  6 Apr 2022 02:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649211331;
        bh=aiGeeVTGnN8zGL5U5c5Yc8F67GA9MLx7+zRzZUbqfWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZ1Sh5SobwI1WfmoEINwRldz9HBH8Zzrs1hWiTrmg/h2kja/2rPhecWSLUhwD0Pry
         zPCNv+TOGm9OjGUxWd8bORtuqDc00NybEboBvQgHTa/5OqqYSQMJ+tPhPdawrLK9hl
         WEFQzduKC8o7JV+opAyYA3DUnHpCQMzKMQJ7/EUN+KlY/ViVKmZCej9DtXM++i0kYi
         vZjMy9VPx1XFKBVfeZzhqEH/r9lWL/jZ+KnGui0arUFAp+Jk6g89j0Ff7j26GwDvZ1
         z241MhZZfj7IfDLYoY3kPSX/0F44T7tKv94ZMSnvGNUQcKQ0vLPHBy9oiV+CNX6roc
         M53qoh0wN6w+w==
Date:   Wed, 6 Apr 2022 10:15:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 4/8] ARM: dts: imx6qdl-vicut1: update gpio-line-names
 for some GPIOs
Message-ID: <20220406021524.GJ129381@dragon>
References: <20220221095312.3692669-1-o.rempel@pengutronix.de>
 <20220221095312.3692669-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221095312.3692669-4-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:53:08AM +0100, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> countedX lines have different board names (YACO_x). And REV_ and BOARD_ pins
> have multiple functions. So, use names exposed to the OS.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks!
