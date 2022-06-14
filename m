Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0704C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 06:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245623AbiFNGgk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 02:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiFNGgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CA9537BE1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655188592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KQn/p+WJIVQNFwoaQTH0dpkpBNJBvLUauZgDvuzZ+Bc=;
        b=cB6lCVOm7QKlMKx1PbRPXpnKKohgwdOT5J/Ckq9vxNd5xJz4LjLMvBdYEJVDMhEm3qKqTi
        trSlms/UoipaD5blJ8l9+Gcj1ujEF8JD9oV9NjlZGESvFfUdcaqfDgQ4z70fYZd/Ew9lAU
        dGPlY85MKlzk6THVfG/56ZVG7dSWS80=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-nmntQT17OOOf6gW6NQ7IYQ-1; Tue, 14 Jun 2022 02:36:21 -0400
X-MC-Unique: nmntQT17OOOf6gW6NQ7IYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B10E811E80;
        Tue, 14 Jun 2022 06:36:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6889FC28115;
        Tue, 14 Jun 2022 06:36:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yqe6EjGTpkvJUU28@ZenIV>
References: <Yqe6EjGTpkvJUU28@ZenIV> <YqaAcKsd6uGfIQzM@zeniv-ca.linux.org.uk> <CAHk-=wjmCzdNDCt6L8-N33WSRaYjnj0=yTc_JG8A_Pd7ZEtEJw@mail.gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        nvdimm@lists.linux.dev
Subject: Re: [RFC][PATCH] fix short copy handling in copy_mc_pipe_to_iter()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1586152.1655188579.1@warthog.procyon.org.uk>
Date:   Tue, 14 Jun 2022 07:36:19 +0100
Message-ID: <1586153.1655188579@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> What's wrong with
>         p_occupancy = pipe_occupancy(head, tail);
>         if (p_occupancy >= pipe->max_usage)
>                 return 0;
> 	else
> 		return pipe->max_usage - p_occupancy;

Because "pipe->max_usage - p_occupancy" can be negative.

post_one_notification() is limited by pipe->ring_size, not pipe->max_usage.

The idea is to allow some slack in a watch pipe for the watch_queue code to
use that userspace can't.

David

