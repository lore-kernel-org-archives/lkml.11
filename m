Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC10C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jun 2022 08:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbiFLI6o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jun 2022 04:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiFLI6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 04:58:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108803FBCD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8949V5CkqyzJmj/F28orMCphXAq0WN6FhR9kVZMtcgQ=;
        t=1655024321; x=1656233921; b=nhagWru/09LdxRa962Zudz0HTQ5L+kd3ndJwl/+yVFnD6C1
        1HqMioOOIU7Cfa6EeFZH6+Rv3MmVykO5Til+bFxDxOtlb917RtqoroOyOYtCtDZqw7nwN42DxR1tk
        Pjw8W0ud84oTK6wjSO/AaAXWDYQWcwSsSsC0tVTnqziLRRE2AfkcTaDrNghqGwAjecu5EzFF5nvPP
        vEnoFKs5msOW7TmyWw5T6cgnV5LOcQCa//zce0AZW9Fp06lxOXnn+gR11kvuTvODHJE1tS3HVkCNQ
        h7a/B9n845fYPVNTVuBqSaGQg030La0fjng2wI5wnU6a2u+LcN68sX5kCS3VHEuQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o0JQL-003NzK-1O;
        Sun, 12 Jun 2022 10:58:21 +0200
Message-ID: <726db8fdf6c7fc271a825badbf1b07a5eebe6d36.camel@sipsolutions.net>
Subject: Re: [PATCH] um: virt-pci: set device ready in probe()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        kernel@axis.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 12 Jun 2022 10:58:20 +0200
In-Reply-To: <20220610203029-mutt-send-email-mst@kernel.org>
References: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
         <20220610203029-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-10 at 20:34 -0400, Michael S. Tsirkin wrote:
>=20
> Also fixes this commit:
>=20
> commit 68f5d3f3b6543266b29e047cfaf9842333019b4c
> Author: Johannes Berg <johannes.berg@intel.com>
> Date:   Fri Mar 5 13:19:58 2021 +0100
>=20
>     um: add PCI over virtio emulation driver

Hm, why? It worked before the harden change.

> BTW Johannes I think you need to spec this device and get
> an ID - what's the plan for that? Current hack of punting
> this to userspace isn't really any good long term.

Yeah, agree, it dropped off my radar (and the process is a bit
cumbersome IMHO).

But I'm not quite sure what you mean wrt. "punting to userspace", here
in the virt-pci code I'm punting to the Kconfig :-)

Did you just mix that up, or was there some additional userspace thing
you're thinking of?

The only userspace thing I can think of it is in virtio_uml where you
have the ID on the command-line, but that's because it implements the
virtio device bus over vhost-user which doesn't have ID discoverability
in the protocol. That could also be fixed I guess, but it's a bit of a
chicken & egg problem, if you don't have the ID and discovering it were
not supported, you'd end up with an unusable device unless you specified
the ID, in which case you don't need to discover it...

johannes
