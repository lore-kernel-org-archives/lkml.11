Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CBEC00140
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 16:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbiHXQsd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 12:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbiHXQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:48:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91054E635;
        Wed, 24 Aug 2022 09:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86B0AB825C1;
        Wed, 24 Aug 2022 16:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A536C433C1;
        Wed, 24 Aug 2022 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661359707;
        bh=xrOUjycMnEHNkuR/d7sV3GIe7heq5KrSGowgk/OuPPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HgnZoLtvIseqBQOyaVW245Mzany4yWkYpwCiUYGOdZ0QBopaAKPREjnGlyedAbIWU
         nDSY777RkQizY1LDGioyCjFFjYeNK2xmlhdv2CLpe71rUkFO9j5z9AkVFkbBfRmUbV
         ist4ZzIeJVFu0yEogXix9Qj7QzgVBfshsi3ZPJrg=
Date:   Wed, 24 Aug 2022 18:48:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jean-Francois Le Fillatre <jflf_kernel@gmx.com>
Cc:     oliver@neukum.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] r8152: add PID for the Lenovo OneLink+ Dock
Message-ID: <YwZWWIyBD7nz5P8l@kroah.com>
References: <20220824162751.11881-1-jflf_kernel@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824162751.11881-1-jflf_kernel@gmx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 06:27:51PM +0200, Jean-Francois Le Fillatre wrote:
> From: JFLF <jflf_kernel@gmx.com>

Doesn't match the signed-off-by line :(

