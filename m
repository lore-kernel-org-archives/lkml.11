Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666FCC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 06:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243252AbiC3GYX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 02:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbiC3GYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:24:20 -0400
X-Greylist: delayed 12263 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Mar 2022 23:22:33 PDT
Received: from uriel.iewc.co.za (uriel.iewc.co.za [IPv6:2c0f:f720:0:3:d6ae:52ff:feb8:f27b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC2C51322;
        Tue, 29 Mar 2022 23:22:33 -0700 (PDT)
Received: from [2c0f:f720:fe16:c400::1] (helo=tauri.local.uls.co.za)
        by uriel.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1nZRiw-0002Oj-CB; Wed, 30 Mar 2022 08:22:30 +0200
Received: from [192.168.42.207]
        by tauri.local.uls.co.za with esmtp (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1nZRiv-0003gx-AZ; Wed, 30 Mar 2022 08:22:29 +0200
Message-ID: <10c1e561-8f01-784f-c4f4-a7c551de0644@uls.co.za>
Date:   Wed, 30 Mar 2022 08:22:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: linux 5.17.1 disregarding ACK values resulting in stalled TCP
 connections
Content-Language: en-GB
To:     Eric Dumazet <edumazet@google.com>
Cc:     Neal Cardwell <ncardwell@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>
References: <E1nZMdl-0006nG-0J@plastiekpoot>
 <CADVnQyn=A9EuTwxe-Bd9qgD24PLQ02YQy0_b7YWZj4_rqhWRVA@mail.gmail.com>
 <eaf54cab-f852-1499-95e2-958af8be7085@uls.co.za>
 <CANn89iKHbmVYoBdo2pCQWTzB4eFBjqAMdFbqL5EKSFqgg3uAJQ@mail.gmail.com>
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <CANn89iKHbmVYoBdo2pCQWTzB4eFBjqAMdFbqL5EKSFqgg3uAJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 2022/03/30 05:48, Eric Dumazet wrote:
> On Tue, Mar 29, 2022 at 7:58 PM Jaco Kroon <jaco@uls.co.za> wrote:
>
> I do not think this commit is related to the issue you have.
>
> I guess you could try a revert ?
>
> Then, if you think old linux versions were ok, start a bisection ?
That'll be interesting, will see if I can reproduce on a non-production
host.
>
> Thank you.
>
> (I do not see why a successful TFO would lead to a freeze after ~70 KB
> of data has been sent)

I do actually agree with this in that it makes no sense, but disabling
TFO definitely resolved the issue for us.

Kind Regards,
Jaco

