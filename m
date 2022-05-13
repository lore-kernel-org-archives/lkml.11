Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B97C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 10:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379485AbiEMKYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379422AbiEMKXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:23:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E99D178560
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:23:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D61AB82D74
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E211C34100;
        Fri, 13 May 2022 10:23:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="p0hyA9bC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652437394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8oam4uQpj40FXUylUvCQDj4pkGlt2TutOpdMK9XnVVA=;
        b=p0hyA9bCLfWirBqsLr28cFLNt3fvOgsRbfypam++KexYG4fYHBEQXjs4DgkYpD99uIgxLB
        A/7U+xhG6rJIo3gSiJrFkEs0Eo7ZkM37oJyvmva5U5696Mixq9D104yuY1Xfov3+I84mVZ
        5ym9BWS+x7TtUwImc3qt+GcgfNQ91kQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4506914a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 13 May 2022 10:23:14 +0000 (UTC)
Date:   Fri, 13 May 2022 12:23:13 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] random: avoid init'ing twice in credit race
Message-ID: <Yn4xke0zvIU3bmsu@zx2c4.com>
References: <20220509121409.529788-1-Jason@zx2c4.com>
 <Yn35bNS6RlElAGYh@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yn35bNS6RlElAGYh@owl.dominikbrodowski.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik,

On Fri, May 13, 2022 at 08:23:40AM +0200, Dominik Brodowski wrote:
> Am Mon, May 09, 2022 at 02:14:08PM +0200 schrieb Jason A. Donenfeld:
> > Since all changes of crng_init now go through credit_init_bits(), we can
> > fix a long standing race in which two concurrent callers of
> > credit_init_bits() have the new bit count >= some threshold, but are
> > doing so with crng_init as a lower threshold, checked outside of a lock,
> > resulting in crng_reseed() or similar being called twice.
> 
> Sidenote: crng_reseed() did manage quite fine if called twice in short
> order.

With regards to crng_finialize, it did, but not with regards to
prematurely emptying patches and all that. IOW, buggy but not that bad.

> 
> > In order to fix this, we can use the original cmpxchg value of the bit
> > count, and only change crng_init when the bit count transitions from
> > below a threshold to meeting the threshold.
> > 
> > Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> 	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
> Thanks,
> 	Dominik

Jason
