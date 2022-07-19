Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62023C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 01:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiGSBaP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 21:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGSBaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:30:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3357DE004;
        Mon, 18 Jul 2022 18:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 312F8B816F9;
        Tue, 19 Jul 2022 01:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B61C341C0;
        Tue, 19 Jul 2022 01:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658194207;
        bh=/MwliW6x3MANt4eBjWgWpaFHMZYqTEfNnB9hkWRAZ8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Iia6o+e7yixpxfwrKILZm0UKqTShBJIWP0XbCw5nqTauuD24mLI5g/MbCuzYPn/ze
         VML8NygzVuV2G+cwaGGUMP3NOIrqipQ47QLsojUOr89cv4etaBhgGhm6aLnUEhntxf
         IIdJPqTlTek5YVVbriyLem9bhyeCBJi/Wlz0C7df1EAHO0tLal5bVnKvOnAmrRH1eS
         mjHUK4okl7IOLYIzMy2Mx4UpWXOF+ORfEbULwwNyTYRL8Zqs/+RtjaUtvYOZSbLZax
         oXvBzz4mjLPIHzSovagB3d28gxZ+QKn215S+kzOsa0SR7AT1LAPyYmNRhYwjoVgZBF
         PI7OjP5h7mLdQ==
Date:   Mon, 18 Jul 2022 18:30:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [net-next PATCH v2 03/15] net: dsa: qca8k: move
 qca8kread/write/rmw and reg table to common code
Message-ID: <20220718183006.15e16e46@kernel.org>
In-Reply-To: <62d60620.1c69fb81.42957.a752@mx.google.com>
References: <20220719005726.8739-1-ansuelsmth@gmail.com>
        <20220719005726.8739-5-ansuelsmth@gmail.com>
        <62d60620.1c69fb81.42957.a752@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 03:00:13 +0200 Christian Marangi wrote:
> This slipped and was sent by mistake (and was just a typo fixed in the
> title)
> 
> Please ignore. Sorry.

Please make sure you wait 24h before reposting, as per

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#i-have-received-review-feedback-when-should-i-post-a-revised-version-of-the-patches

BTW what is your name? Christian Marangi or Ansuel Smith? :S
