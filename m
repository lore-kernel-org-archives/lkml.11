Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE91C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 12:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbiBWMbm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbiBWMbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:31:39 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4EB99EFF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sTSSDe4IJOkHZIbaqdrBiwjneU8aircmvEk/fy7O5PM=; b=b1CC5kJCIdB+ONSYpI4fQ1d6zc
        0LdD7OLX/vpU+mVFyDvhu7xTn+lpI4ckUlc2783K84gYh2mpRBsmlRHB/qD1fD1A5mzAAd8MC1oCT
        AVlLmyV7cmq/29T0T9WUnC+wG58HRQ3lUQkVEEJqgAUr2CpKDYtP52MCm5qM7co+9i4Q+jr5SiXTc
        WFca8qG1kuupfnVjYANhVlHqE3AN+aFc5aGq2peuLvctMfVDPBLFOxjQn2jy5aaw98kZ2zc5N8eBZ
        TIBRaiOT6noPCBgKt7npUuDlPz+0Ous2in8kdYlHNgDGYuO4RoAvsbimCN1Ue3vykjXmP3HBrLR4n
        TqkcNmuA==;
Received: from [189.79.213.38] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nMqnP-000A55-2e; Wed, 23 Feb 2022 13:31:03 +0100
Message-ID: <7ea61d75-c924-0ef8-e2a9-463540ce1450@igalia.com>
Date:   Wed, 23 Feb 2022 09:30:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, anton@enomsg.org,
        ccross@android.com, dyoung@redhat.com, feng.tang@intel.com,
        john.ogness@linutronix.de, keescook@chromium.org,
        kernel@gpiccoli.net, kexec@lists.infradead.org,
        rostedt@goodmis.org, tony.luck@intel.com, vgoyal@redhat.com,
        Petr Mladek <pmladek@suse.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YgvRe92hEvj5mEUS@alley> <YhYdVYYapkaVdvZE@google.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YhYdVYYapkaVdvZE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2022 08:41, Sergey Senozhatsky wrote:
> On (22/02/15 17:14), Petr Mladek wrote:
>> Makes sense and looks good to me.
>>
>> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> FWIW
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Thanks a lot Sergey, for your review =)

Andrew, do I need to send a V7 with the above tag or this is
incorporated when patch gets into your tree?

Thanks!
