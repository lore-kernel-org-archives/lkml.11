Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CF1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 15:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiCaPYL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238170AbiCaPYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:24:07 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89243220FEE;
        Thu, 31 Mar 2022 08:22:15 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id F164092009C; Thu, 31 Mar 2022 17:22:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id EB0E692009B;
        Thu, 31 Mar 2022 16:22:13 +0100 (BST)
Date:   Thu, 31 Mar 2022 16:22:13 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PING^2][PATCH] Alpha: Remove redundant local asm header
 redirections
In-Reply-To: <alpine.DEB.2.21.2202131944000.34636@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2203311612440.26399@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202131944000.34636@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2022, Maciej W. Rozycki wrote:

> Remove a number of asm headers locally redirected to the respective 
> generic or generated versions.

 Ping for: 
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2202131944000.34636@angie.orcam.me.uk/>

 BTW, has anybody heard from Richard Henderson lately?  His twiddle.net 
domain no longer resolves, and it was like this with the previous ping 
already.

  Maciej
