Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E94ECAA27
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 17:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240832AbiHYRoK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 13:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHYRoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:44:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35C8B6D2A;
        Thu, 25 Aug 2022 10:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85609B82A39;
        Thu, 25 Aug 2022 17:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC43C433C1;
        Thu, 25 Aug 2022 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661449444;
        bh=3xJLBFKHRtXT311VApMRPg+Hs2bjaZNUbyoQV13y1Zk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I30JF3p5fLskWzNn7g5ZlKjaoEbzQbHAuYJimIYaa61x28FQ7sybydrR5h1r+vgeJ
         9Qo6v/GgQQV38E/SSylo78EqM+gsZNhX73tKNzSeF66IwU1P3CqmBTMq60ltUZeVV/
         +SPrgC00rsJixACKSGMJgfWM9QseEAbayTvoXvk5Y3kjpx31Z7vpoGEwGWCaWP/vn1
         vE2ql+VhlFUf5rM5PJSAmJOH9Tdap5Ln5cec7EkoJzKBHl4uY2iZpzwPlNQb9zEaPf
         jxwbgahcD/lIsMuMfqYdQQsNIelPAFPytC5oYcY4DTDR6P96JayGEcghYy6Pin+XJ5
         BLS87Gk3svDug==
Date:   Thu, 25 Aug 2022 10:44:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, Josef Bacik <josef@toxicpanda.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tg3: Disable tg3 device on system reboot to avoid
 triggering AER
Message-ID: <20220825104403.740cac15@kernel.org>
In-Reply-To: <20220825063852.1120632-1-kai.heng.feng@canonical.com>
References: <20220825063852.1120632-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 14:38:52 +0800 Kai-Heng Feng wrote:
>  	rtnl_lock();
> +
> +	tg3_reset_task_cancel(tp);

Doesn't this "task" take rtnl_lock()? Looks deadlocky.
