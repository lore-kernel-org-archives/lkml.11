Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4A2C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 10:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbiFHKjp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 06:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbiFHKhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:37:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412BC1C0CAB;
        Wed,  8 Jun 2022 03:32:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F47C60B34;
        Wed,  8 Jun 2022 10:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5058FC34116;
        Wed,  8 Jun 2022 10:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654684353;
        bh=osDczLjj4ZYroNunuCS3ak/VSb8vsNR1fW33YV9phho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3lW5FGu3iAa/NSQmbsLon1kjR4KgXKD67qUlrMGzcW4cgHwwNmQzzHoP+lkMOiA0
         S/BruE+qR24kXn+bmpTBTOh6zVgTTw+uZDb9W4MZHSy1vFH6/V+Tny9leO+YxGzygF
         6ElCKSPTLJdoW8mycnCEhVlCNh8cColyUXUKlOqE=
Date:   Wed, 8 Jun 2022 12:32:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Caleb Connolly <kc@postmarketos.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.18 579/879] pinctrl/rockchip: support deferring other
 gpio params
Message-ID: <YqB6vmoGsWHAVI29@kroah.com>
References: <20220607165002.659942637@linuxfoundation.org>
 <20220607165019.660801561@linuxfoundation.org>
 <c5c7e071-a645-39a2-c3dc-897173e8c971@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c7e071-a645-39a2-c3dc-897173e8c971@postmarketos.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 11:25:02AM +0100, Caleb Connolly wrote:
> Hi Greg,
> 
> This commit contains a bug which was fixed in commit
> 42d90a1e5caf ("pinctrl/rockchip: support setting input-enable param")

Thanks for letting me know, have now picked that one up too.

greg k-h
