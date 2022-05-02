Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839D5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 21:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387703AbiEBVjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 17:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387708AbiEBViy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:38:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15712AEA;
        Mon,  2 May 2022 14:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C3F2610A2;
        Mon,  2 May 2022 21:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE92C385A4;
        Mon,  2 May 2022 21:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651527323;
        bh=JQlhWUdt5hFLtKr37+zH2vvNvGjSiMJ+6VapbGrJxNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Je8Assa0vA995iDge5hh7xALu5lsOaY8MZ4ThHq1cRlAlZB4JevmLZmWfFEoit9RJ
         BneRF1QGmgFOs2/eJpVdv5l17wA2HzHGFEiEvjA39yN7WZoegTsO8fRZ5JktbFjTK0
         aA3Sjusbyh0bHgHLRoHUMXS4F6GYDDLy9AyN0D+C08d/pKo1fYq9pC3Cbqns0OXMRy
         sRmICZB/I1quQvKhAPNcWVZ5vf0csauMY9UOz9Skui7G9iahKmGiZlA3MZECWX99Js
         88suibN4r7kQp4h3qoe0W5HGAdE+wkCsX7vuvg5RAITstv3vbg9gi6R3lrgFsGPWSZ
         HZ9MIuefpRcNA==
Date:   Mon, 2 May 2022 14:35:22 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Vilas R K <vilas.r.k@intel.com>,
        linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 0/2] vsock/virtio: add support for device
 suspend/resume
Message-ID: <20220502143522.2ea422c9@kernel.org>
In-Reply-To: <20220428132241.152679-1-sgarzare@redhat.com>
References: <20220428132241.152679-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 15:22:39 +0200 Stefano Garzarella wrote:
> Vilas reported that virtio-vsock no longer worked properly after
> suspend/resume (echo mem >/sys/power/state).
> It was impossible to connect to the host and vice versa.
> 
> Indeed, the support has never been implemented.
> 
> This series implement .freeze and .restore callbacks of struct virtio_driver
> to support device suspend/resume.
> 
> The first patch factors our the code to initialize and delete VQs.
> The second patch uses that code to support device suspend/resume.

This set got a "Not Applicable" in patchwork, I'm not sure why.
Michael I presume net-next is fine? Can we get an Ack?
