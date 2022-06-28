Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D83C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 11:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345160AbiF1L5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 07:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344997AbiF1L5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:57:47 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9A032055
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:57:47 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3176d94c236so114507107b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLZdrC+swnkCKR0I6SG4QWd9p3MVQZBE19TS1zpMRXw=;
        b=b3TStvl9YDWhqzJY2DvGVjkqLn4eFR4cFB5BI+2vlB8L98qodsAogGh9Fy4QfAgudQ
         aO9vAtg9XFwgWNPZjbf3Y3YewdzERAnmNWa2AibsAMhDnzPssOAh6uqP4VYXdC3NjMsj
         z6uMvk7gp8QhYiE4HGEgMC4QT/sK7+nuJS3picYKEprfop0deeHezTsyEohj5AQmt8EN
         xho2UmIZYtqBvOnvJhEv7JbopWimiMNgPRUdKEVdm1CB183nYSPwBdZLzEwzMSdjNo45
         o3YRY49SW7sqL0+LXSbEsxsevL0D2hX54lPzxYez85wDeXeach0zJr7+SVg9lrvK19Dq
         hlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLZdrC+swnkCKR0I6SG4QWd9p3MVQZBE19TS1zpMRXw=;
        b=VThJBMRFCy5arGLBEhmnPtPLNQtFtNPSuRmqoOz9k1SSl5pRf6DXN+lfO3SaLGc5yJ
         Oc7NLAKZz75x77kbl4wcgcqI7GMo2SEMs2pjEX8l8tjSzXGNsLk3I4pj2quC+BekY87z
         YnAvNDG+vQ3U/+C23DYhwpY8bjZFq7eNLFVXxKtWx04KB/hNMzRQB239Q8C/H2rd9KNb
         Y6F0C8jv+1PRZMFmXchqnymVI1qEfVRM5lND6Xlgr1BfXa6muc+sqbfc9wpO5jn9XHTi
         P4+I8Q36GkkRBHhcI3a+6hlS9elyxCOyn7sqebHXMVOgqmKo6xNTZF2y8mSPz1EI8GU7
         RFKA==
X-Gm-Message-State: AJIora+eYExh1CaE8dtsQtcO9Q8uMrvtDQvKIHx9kbL51fNlyk6SA4p7
        guBLy7kj8IiZlosTgRJEESwmzv3c9R+e1lGNitXo+w==
X-Google-Smtp-Source: AGRyM1tqpFMzemg8g47JeYue9sdLoY13F98Rp4MmgardxNEJXXi1KU8knn77vx906pR3dNjnWzA3JBw9b6tmjutNX9c=
X-Received: by 2002:a81:e93:0:b0:317:8db7:aa8e with SMTP id
 141-20020a810e93000000b003178db7aa8emr21314397ywo.55.1656417466312; Tue, 28
 Jun 2022 04:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220628035030.1039171-1-zys.zljxml@gmail.com>
In-Reply-To: <20220628035030.1039171-1-zys.zljxml@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 28 Jun 2022 13:57:35 +0200
Message-ID: <CANn89iK=SYDOXcTa=bEwr7-sr63c+zWd-t4FcezU2S9296zkOQ@mail.gmail.com>
Subject: Re: [PATCH v3] ipv6/sit: fix ipip6_tunnel_get_prl return value
To:     zys.zljxml@gmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        katrinzhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 5:50 AM <zys.zljxml@gmail.com> wrote:
>
> From: katrinzhou <katrinzhou@tencent.com>
>
> When kcalloc fails, ipip6_tunnel_get_prl() should return -ENOMEM.
> Move the position of label "out" to return correctly.
>
> Addresses-Coverity: ("Unused value")
> Fixes: 300aaeeaab5f ("[IPV6] SIT: Add SIOCGETPRL ioctl to get/dump PRL.")
> Signed-off-by: katrinzhou <katrinzhou@tencent.com>
> ---
>

Reviewed-by: Eric Dumazet<edumazet@google.com>
