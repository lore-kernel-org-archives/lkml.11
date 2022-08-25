Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A64C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 10:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbiHYKAL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 06:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHYKAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB5837FAD
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661421607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Tq1zsr7zrYFwkPaHdBsH4WoR9jozHjv6oFZQItNY9s=;
        b=cccqg9Nq8ugYhYoRNKchryjFX2sSnu4rbTrfeMEnzQ5Afsxe41IlaM0ydQUMsW5BzfEHbY
        3hLGMof08fM2mau8gXUovCzaHuiHswpHXOTrKKqyubSvkQ6gK9naGFf+oADHhDIzMuFPTq
        nwUIOSkZsVwnNvMt8qAiDTpSsO7EVz4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-tsHqy3GhMD25JslMfibTwA-1; Thu, 25 Aug 2022 06:00:00 -0400
X-MC-Unique: tsHqy3GhMD25JslMfibTwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDD991C068C0;
        Thu, 25 Aug 2022 09:59:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.195.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FCF62166B26;
        Thu, 25 Aug 2022 09:59:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id E2D651800082; Thu, 25 Aug 2022 11:59:57 +0200 (CEST)
Date:   Thu, 25 Aug 2022 11:59:57 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Lingfeng Yang <lfy@google.com>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: Fix same-context optimization
Message-ID: <20220825095957.jjwx7inatburplox@sirius.home.kraxel.org>
References: <20220812224001.2806463-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812224001.2806463-1-robdclark@gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 03:40:00PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> When VIRTGPU_EXECBUF_RING_IDX is used, we should be considering the
> timeline that the EB if running on rather than the global driver fence
> context.
> 
> Fixes: 85c83ea915ed ("drm/virtio: implement context init: allocate an array of fence contexts")
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Pushed to drm-misc-next.

thanks,
  Gerd

