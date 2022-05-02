Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF24C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 23:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiEBXKu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 19:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiEBXKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:10:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E122ED65;
        Mon,  2 May 2022 16:07:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C83B0CE1C5A;
        Mon,  2 May 2022 23:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D66C385AC;
        Mon,  2 May 2022 23:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651532832;
        bh=/4/hi9vNaDgvtczEHBpbQY6P8/Xh9fnOLxV6F6kQcfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h9lRtZB7kFGMP0rRl9XrlMSelc3fH/Jv2Q/JOv9e+r54tKtjqTRk1FdO8H0FenauZ
         L1v7Rtgw/mbkzuU1FYBMcrNus6fcxgOVDRh89ID3Dxecn9pA4shzypnnb2negH6ZD8
         FefkI/np6URrEOU55GYfA2/HL2wojL1fwhSXPiwGHzlOZZUnijVQe2HmKYyeYeObS9
         sMhBqEKe3ZltoOWt4wiS+tyCoxoyfzmzuX5WuBtCWTwwpytAU9xVYc3eMJXWBRGBlO
         dU++Kwt2WA6CO/0xnT5er/9SJlSeIuaMglKBErJ7Ugz0w8vtTEglmTQHUPDOzv1nCy
         E3Bsz9pTSbxcw==
Date:   Mon, 2 May 2022 16:07:10 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Vilas R K <vilas.r.k@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] vsock/virtio: add support for device
 suspend/resume
Message-ID: <20220502160710.68381a27@kernel.org>
In-Reply-To: <20220502180554-mutt-send-email-mst@kernel.org>
References: <20220428132241.152679-1-sgarzare@redhat.com>
        <20220502180554-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2022 18:20:51 -0400 Michael S. Tsirkin wrote:
> On Thu, Apr 28, 2022 at 03:22:39PM +0200, Stefano Garzarella wrote:
> > Vilas reported that virtio-vsock no longer worked properly after
> > suspend/resume (echo mem >/sys/power/state).
> > It was impossible to connect to the host and vice versa.
> > 
> > Indeed, the support has never been implemented.
> > 
> > This series implement .freeze and .restore callbacks of struct virtio_driver
> > to support device suspend/resume.
> > 
> > The first patch factors our the code to initialize and delete VQs.
> > The second patch uses that code to support device suspend/resume.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>  
> 
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Commit 0530a683fc85 ("Merge branch
'vsock-virtio-add-support-for-device-suspend-resume'") in net-next, now.
Thank you!
