Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D2CCCA47E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 19:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbiFBTKf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 15:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbiFBTKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:10:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8282660E1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:10:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id B4C791F454B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654197026;
        bh=IlvubttWe0/N+C/kJAK867PWFNBquuDF6pRN/+k26E0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E9K22y9xSbYOgCvppmK7gqcQN0asfUc+h+JV3bqyZQlvr+QjTgRKKhpwZoSrTYvmY
         DC0NdqdE8hgbcKGo7Klb+PS7q6Bp565R2cf8TQl8X/WrdQ4tn64M3FY2BgAtMopkxj
         Y9v7X9mAMiAMetm8ChdikjuZEfRs+7Dgq4zbv7gJd+396yP5QRhwGjDb8PYXHNedrY
         BtLACziZNpGIieoqhLMpKROV8vUyUUg+BRnwitJS5pajpTVTiMGJhF0JEogk+KXf3/
         d0vYvGX3RgTw7pfpuxsDUTbT1U8JvpOW1KMWZqnF9/8ROASyotxs3IIYvYGO4g3/5O
         etEUTWm4hZzdw==
Message-ID: <c8f18b5f-5ecd-e072-03fc-3d4845be1ae2@collabora.com>
Date:   Thu, 2 Jun 2022 22:10:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1] kernel/reboot: Use static handler for
 register_platform_power_off()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220531221102.1112968-1-dmitry.osipenko@collabora.com>
 <CAJZ5v0ifhxy-b50TyJdmzkJ_rnYyn7euzRc4-2bG_oxu-juCtw@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAJZ5v0ifhxy-b50TyJdmzkJ_rnYyn7euzRc4-2bG_oxu-juCtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/22 21:40, Rafael J. Wysocki wrote:
..
> Applied now (with the tags from Geert), but if there are any more
> followup changes in that area, can you please CC them to linux-pm, so
> people who have seen your original series can see them too?
> 
> Thanks!

Sure, I actually wanted to CC linux-pm, but missed twice to update the
send-mail command from the bash history. Thank you all!

-- 
Best regards,
Dmitry
