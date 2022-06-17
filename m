Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8956C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 14:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382836AbiFQOlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 10:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382808AbiFQOlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:41:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31253517C2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:41:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC122B82ACA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 14:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1494FC3411F;
        Fri, 17 Jun 2022 14:41:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QzkYhGe9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655476869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d8vYn2o7BallV+Qa266BjqpvAHp10+eqXCKCBj7r/eo=;
        b=QzkYhGe99W1kq2eyE2vfuWMPLRmckrTq5O2txU8I/ySiZrfGA19pjm7Jh2zbGz7f2km2eE
        ZTj7z3HPmLA0BscMpOvDmsj7XopUMTzWYXu/SrLGdRlGixRfXiiJTElcz5V2HhZq6mIRpn
        BRDJJSv9+aQ3HCrEw47R0oEbBSSbZsg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 87fa2686 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 17 Jun 2022 14:41:09 +0000 (UTC)
Date:   Fri, 17 Jun 2022 16:41:05 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: 5.19 printk breaks message ordering
Message-ID: <YqySgdH3sGj7o9O8@zx2c4.com>
References: <YqyANveL50uxupfQ@zx2c4.com>
 <YqyN20jpRw1SaaTw@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqyN20jpRw1SaaTw@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 04:21:15PM +0200, Petr Mladek wrote:
> In fact, in your case you might get even better synchronization
> if you do it the other way and write userspace messages into
> the kernel log via /dev/kmsg:
> 
>      echo "Hello world" > /dev/kmsg

The idea is to interleave stderr/stdout properly, as CI has done for
ages, which threaded printk breaks, and which my patch (now posted)
fixes behind a default-off option. You can't dup2 /dev/kmsg to 1 and 2,
as the write() semantics are different, with respect to buffering and
with respect to new lines. The interfaces aren't comparable, so this
isn't quite a solution. (Besides, not breaking things as they currently
exist has a certain benefit.)

Jason
