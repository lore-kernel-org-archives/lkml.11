Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D6CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 17:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiDMRnt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbiDMRnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 649826CA47
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649871678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOtKwh35pM24cRsOHUqNHS8xyukFMTImg3mtxCkuSPU=;
        b=iWpToYk0b7ov44UyBhypSWwmPAgd2W5nQ7lX5XpLvwn7oYgqe81J+dMht5QEK0MRg12ow/
        Er9NQQQRg+Urzz3xraXrZru165p2fuH34e9vs65+HLVuij/DYHErve8DKEP8hM38MK0YiS
        lN5jsqimEDX095LH7KKVi665jD+62mc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-zZZBnxM1PH6p-aj--as1kQ-1; Wed, 13 Apr 2022 13:41:14 -0400
X-MC-Unique: zZZBnxM1PH6p-aj--as1kQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 572C73802AC7;
        Wed, 13 Apr 2022 17:41:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DD8640D282A;
        Wed, 13 Apr 2022 17:41:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CANn89iLEch=H9OJpwue7HVJNPxxn-TobRyoATHTrSdetwpHVXA@mail.gmail.com>
References: <CANn89iLEch=H9OJpwue7HVJNPxxn-TobRyoATHTrSdetwpHVXA@mail.gmail.com> <164984498582.2000115.4023190177137486137.stgit@warthog.procyon.org.uk>
To:     Eric Dumazet <edumazet@google.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Restore removed timer deletion
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2419531.1649871672.1@warthog.procyon.org.uk>
Date:   Wed, 13 Apr 2022 18:41:12 +0100
Message-ID: <2419532.1649871672@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <edumazet@google.com> wrote:

> ok... so we have a timer and a work queue, both activating each other
> in kind of a ping pong ?

Yes.  I want to emit regular keepalive pokes.

> Any particular reason not using delayed works ?

Because there's a race between starting the keepalive timer when a new peer is
added and when the keepalive worker is resetting the timer for the next peer
in the list.  This is why I'm using timer_reduce().  delayed_work doesn't
currently have such a facility.  It's not simple to add because
try_to_grab_pending() as called from mod_delayed_work_on() cancels the timer -
which is not what I want it to do.

David

