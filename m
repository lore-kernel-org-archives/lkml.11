Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CD6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 10:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiBPKDI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:03:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiBPKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:03:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2E28B65C7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645005774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0NC61oRUgDU9EbfgfbyTVHn9rrZzU7WjlYmOL/jjXmQ=;
        b=IW7JlF2j9KDnzg8IByivb37moNIlpjh6KxlOv7qZZnhuqjpPYcNP3Wy55ihKHQQFHsPaW4
        3N/kJqNx+ttvmPrTxpaVSfWgPpZNKr0o6Lw3JrnQba6CPIFcLTciEnSFn4le9xDwSh/b2X
        smsLEOVprqGuFnsfZ7Ilfi1WUaRJPyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-I9HDI2adMomQ1N2hZ8UEBg-1; Wed, 16 Feb 2022 05:02:51 -0500
X-MC-Unique: I9HDI2adMomQ1N2hZ8UEBg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F07F1091DA0;
        Wed, 16 Feb 2022 10:02:49 +0000 (UTC)
Received: from localhost (ovpn-13-16.pek2.redhat.com [10.72.13.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9B657B6E9;
        Wed, 16 Feb 2022 10:02:07 +0000 (UTC)
Date:   Wed, 16 Feb 2022 18:02:05 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V5] panic: Move panic_print before kmsg dumpers
Message-ID: <YgzLndmbxeZgkBnK@MiWiFi-R3L-srv>
References: <20220211215539.822466-1-gpiccoli@igalia.com>
 <YgoaNTnT9hc6PUjP@MiWiFi-R3L-srv>
 <ae38ceb0-4af0-f010-5272-3bf1ca037bce@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae38ceb0-4af0-f010-5272-3bf1ca037bce@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/22 at 11:17am, Guilherme G. Piccoli wrote:
> On 14/02/2022 06:00, Baoquan He wrote:
> > [...]
> >> This patch changes that in 2 ways:
> >                                ~~~ steps?
> > 
> > Otherwise, the whole looks straightforward, clear, thanks.
> > 
> > Acked-by: Baoquan He <bhe@redhat.com>
> > 
> 
> Thanks a lot Baoquan, just sent a V6 including your suggestion and your
> Acked-by - I'm feeling we are close now...heheh

Glad to hear that, and thanks for the effort and patience.

