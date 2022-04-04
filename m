Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45B0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 08:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiDDIrb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 04:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiDDIr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:47:29 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57EF15FE3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:45:32 -0700 (PDT)
Date:   Mon, 04 Apr 2022 08:45:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1649061928;
        bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=DtFqNO/NWFzU8aLGlxKwXWWmvBgwtdE+VXtqM5MGCp0/pkgXeIpmxjBQ6FdRsVI0n
         NT59HleMtIPBpUjqr0pqpxMj0WwxyIVEbsviCp7cYzZKWU0ykX0m9KfzzwPeOyb5b2
         t1edkcD5DVpuS+8LT4jFfT1+z6sC90w/0Jm1cqP+5vipuPS16pbcRaNQRssn8X0rUL
         uP4sAVGa8XZyVGY17r+bIEyc4QjfbYuQSGDcEiop1f/gG4ZgKHHIvXQLhF0WzYEuKr
         wjOrFSI5SSyvBX/FK8siHQaCsWgO/O2RKlm9yvi00QteSRfaxixC1TDTcyuH/+b1VG
         tPtx/mbL0kIrQ==
To:     Randy Dunlap <rdunlap@infradead.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/format_helper: fix a kernel-doc typo
Message-ID: <WPKnaTQnAiZoRATAyNFQMUiR7WhM5qpABAiSRl9R0SFoqf6HGqn8s0wcmrGY1zuU9vxz094jfYmfQgwdYlL2g-sPbFG8ILwk-_6aOiLiT14=@emersion.fr>
In-Reply-To: <20220403232902.1753-1-rdunlap@infradead.org>
References: <20220403232902.1753-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Simon Ser <contact@emersion.fr>
