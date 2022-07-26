Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91C9C04A68
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jul 2022 15:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbiGZPmg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 11:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiGZPmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:42:32 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Jul 2022 08:42:30 PDT
Received: from neo-zeon.de (neo-zeon.de [70.229.12.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F2F2C677
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:42:30 -0700 (PDT)
Received: from neo-zeon.de (localhost [::1])
        by neo-zeon.de (OpenSMTPD) with ESMTP id 359904d2;
        Tue, 26 Jul 2022 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=neo-zeon.de; h=message-id
        :date:mime-version:subject:to:cc:references:from:in-reply-to
        :content-type:content-transfer-encoding; s=1; bh=eSQmzwMTJyGTFWU
        8+xC/HAoUcSc=; b=hwHjKqLQtvX6aMEmlgrDFEwCCjnMP+TNrFVXy/1irFT4sco
        dhQusQUjsbqySE89nq876HqiYJPE0VLmOuIev4cJ/oKoz0iq2McPGSM6nFLQkd9D
        QVvOfuf4TDVXrG/HFXNiouq8mEpKKVEGggZQYrYU8ItQs9u647ODy+6KSMEI=
Received: by neo-zeon.de (OpenSMTPD) with ESMTPSA id 24759ee6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 26 Jul 2022 08:35:49 -0700 (PDT)
Message-ID: <91e34de4-1c85-073f-9c24-ce3133394fe6@neo-zeon.de>
Date:   Tue, 26 Jul 2022 08:35:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] Add support for CLSA0101
Content-Language: en-US
To:     Lucas Tanure <tanureal@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <20220726101131.68058-1-tanureal@opensource.cirrus.com>
From:   Cameron Berkenpas <cam@neo-zeon.de>
In-Reply-To: <20220726101131.68058-1-tanureal@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I can confirm this does _not_ work.

More specifically, with these patches, the original behavior still occurs:
1. You get left channel audio from the right speaker only.
2. No sound at all after resuming from sleep.
3. You get sound after resuming from hibernate, but only as described in #1.

If you apply a patch like this: https://paste-bin.xyz/71355

You  get properly working audio until you put the laptop to sleep or 
hibernate. Upon resuming from either state, you get no audio at all.

On 7/26/22 03:11, Lucas Tanure wrote:
> Add Support for the CLSA0101 laptop, an Intel version of CLSA0100.
> This patch has been tested using the CLSA0100, ensuring it
> doesn't break the sound for it.
> We appreciate it if someone with CLSA0101 could verify that this
> the patch works for them.
>
> Lucas Tanure (2):
>    ALSA: hda: cs35l41: Use the CS35L41 HDA internal define
>    ALSA: hda: cs35l41: Support CLSA0101
>
>   sound/pci/hda/cs35l41_hda.c   | 67 +++++++++++++++++++++--------------
>   sound/pci/hda/patch_realtek.c | 12 +++++++
>   2 files changed, 53 insertions(+), 26 deletions(-)
>

